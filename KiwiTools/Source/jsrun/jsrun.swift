/**
 * @file	jsrun.swift
 * @brief	Define main function for jsrun command
 * @par Copyright
 *   Copyright (C) 2022-2024 Steel Wheels Project
 */

import KiwiLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

@main struct AppBoxCLI {
        static func main() async throws {
                jsrun(arguments: CommandLine.arguments)
        }
}

func jsrun(arguments args: Array<String>)
{
	let console = CNFileConsole()
	let cmdline = CommandLineParser(console: console)
	if let config = cmdline.parseArguments(arguments: Array(args.dropFirst())) {
		//config.dump(console: console)
		let srcfile = config.fileName
		if !FileManager.default.fileExists(atPath: srcfile) {
			console.error(string: "[Error] File is not exist: "
				+ "\(srcfile)\n")
			exit(exitCode: .fileError)
		}
		let env = CNEnvironment(parent: CNEnvironment.shared)
		let result: CNExitCode
		let extname = (srcfile as NSString).pathExtension
		switch extname {
		case "js":
			result = executeFile(fileName: srcfile, scriptArguments: config.scriptArguments, environment: env, console: console)
		case "jspkg":
			result = executePacjkage(packageName: srcfile, scriptArguments: config.scriptArguments, environment: env, console: console)
		default:
			console.error(string: "Unsupported file extension: \"\(extname)\"")
			result = .fileError
		}
		exit(exitCode: result)
	} else {
		exit(exitCode: .commandLineError)
	}
}

private func executeFile(fileName name: String, scriptArguments scrargs: Array<String>, environment env: CNEnvironment, console cons: CNFileConsole) -> CNExitCode
{
	let srcurl   = URL(filePath: name)

	/* Register application directory */
	let dirurl = srcurl.deletingLastPathComponent()
	env.setPackageDirectory(path: dirurl.path)

	let resource = KEResource(singleFileURL: srcurl)
	return executeURL(sourceFile: srcurl, scriptArguments: scrargs, resource: resource, environment: env, console: cons)
}

private func executePacjkage(packageName name: String, scriptArguments scrargs: Array<String>, environment env: CNEnvironment, console cons: CNFileConsole) -> CNExitCode
{
        switch FileManager.default.checkFileType(pathString: name) {
        case .success(let ftype):
                switch ftype {
                case .directory:
                        let pkgurl   = URL(filePath: name)
                        let resource = KEResource(packageDirectory: pkgurl)
                        if let err = resource.loadManifest() {
                                cons.error(string: err.toString())
                                return .commandLineError
                        }
                        /* Register application directory */
                        env.setPackageDirectory(path: name)
                        /* get URL of application */
                        if let appurl = resource.application() {
                                return executeURL(sourceFile: appurl, scriptArguments: scrargs, resource: resource, environment: env, console: cons)
                        } else {
                                cons.error(string: "No application main script is defined")
                                return .compileError
                        }
                case .file:
                        cons.error(string: "Source file is not directory: \(name)")
                        return .fileError
                @unknown default:
                        cons.error(string: "Internal error")
                        return .fileError
                }
        case .failure(let err):
                cons.error(string: err.toString())
                return .fileError
        }
}

private func executeURL(sourceFile srcfile: URL, scriptArguments scrargs: Array<String>, resource res: KEResource, environment env: CNEnvironment, console cons: CNFileConsole) -> CNExitCode
{
	guard let vm = JSVirtualMachine() else {
		return .internalError
	}

	let context  = KEContext(virtualMachine: vm)
	let conf     = KEConfig(applicationType: .terminal, doStrict: true, logLevel: .defaultLevel)

	/* Compile built in library */
	let compiler = KLLibraryCompiler()
	guard compiler.compile(context: context, resource: res, console: cons, environment: env, config: conf) else {
		return .compileError
	}

	/* Execute scripts */
	if let scr = srcfile.loadContents() {
		if !execute(context: context, script: scr as String, sourceFile: srcfile, console: cons) {
			cons.error(string: "Failed to execute script: \(srcfile.path)")
			return .runtimeError
		}
	} else {
		cons.error(string: "Failed to load script: \(srcfile.path)")
		return .fileError
	}
	/* Call main function */
	if let mainval = context.get(name: "main") {
		/* Collect arguments */
		var argvals: Array<JSValue> = []
		for arg in scrargs {
			if let val = allocateArgument(argument: arg, context: context, console: cons) {
				argvals.append(val)
			} else {
				return .runtimeError
			}
		}
		/* Execute main function */
		let retval = mainval.call(withArguments: [argvals])
		if let code = valueToInt(value: retval) {
			return code == 0 ? .noError : .runtimeError
		} else {
			return .runtimeError
		}
	}
	return .noError
}

private func allocateArgument(argument arg: String, context ctxt: KEContext, console cons: CNConsole) -> JSValue? {
	if let val = JSValue(object: arg, in: ctxt) {
		return val
	} else {
		cons.error(string: "Failed to allocate parameters")
		return nil
	}
}

private func terminalSize(console cons: CNFileConsole) -> (Int, Int)
{
	let termctrl = CNFileTerminalController(console: cons)
	termctrl.execute(escapeCodes: [.requestScreenSize])
	return termctrl.screenSize()
}

private func execute(context ctxt: KEContext, script scr: String, sourceFile file: URL?, console cons: CNConsole) -> Bool {
	ctxt.resetErrorCount()
	let _ = ctxt.evaluateScript(script: scr, sourceFile: file)
	if ctxt.errorCount == 0 {
		return true // OK
	} else {
		return false // Error
	}
}

private func exit(exitCode code: CNExitCode)
{
	exit(Int32(code.rawValue))
}

private func valueToInt(value valp: JSValue?) -> Int?
{
	if let val = valp {
		if val.isNumber {
			if let num = val.toNumber() {
				return num.intValue
			}
		}
	}
	return nil
}
