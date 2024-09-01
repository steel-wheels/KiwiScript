/**
 * @file	KHShell.swift
 * @brief	Define KHShell class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

public class KHShell
{
        private var mApplication:	CNApplicationType
	private var mConsole:		CNFileConsole
	private var mPromptBase:	String
	private var mIsRunning:		Bool
	private var mDoExec:		Bool
        private var mReadline:		CNReadline
	private var mVirtualMachine:	JSVirtualMachine
	private var mContext:		KEContext
	private var mEnvironment:	CNEnvironment
	private var mConfig:		KEConfig
	private var mNewline:		String

	public var isRunning: Bool { get { return mIsRunning }}

	public var prompt: String { get {
		return mPromptBase +  "$ "
	}}

	public init(application aptype: CNApplicationType, console cons: CNFileConsole) {
                mApplication	= aptype == .terminal ? .terminal : .window
		mConsole	= cons
		mPromptBase	= "js"
		mIsRunning	= false
		mDoExec		= true
		mReadline	= CNReadline()
		mVirtualMachine	= JSVirtualMachine()
		mContext	= KEContext(virtualMachine: mVirtualMachine)
		mEnvironment	= CNEnvironment(parent: CNEnvironment.shared)
		mConfig		= KEConfig(applicationType: aptype, doStrict: true, logLevel: .defaultLevel)
		mNewline	= CNEscapeCode.newline.encode()

		/* allocate context */
		guard let pkgurl   = CNFilePath.URLForResourceDirectory(directoryName: "jsh.jspkg", subdirectory: nil, forClass: KHShell.self) else {
			fatalError("Can not happen")
		}

		/* setup the context */
		let res  = KEResource(packageDirectory: pkgurl)
		let comp = KHLibraryCompiler()
		let _ = comp.compile(context: mContext, resource: res, console: cons, environment: mEnvironment, config: mConfig)

		/* error message */
		mContext.exceptionCallback = {
			(_ exception: KEException) -> Void in
			cons.error(string: exception.description)
			cons.error(string: "\n")
		}
	}

	public func execute() {
		mIsRunning = true
		print(string: self.prompt, console: mConsole)
		while mDoExec {
			switch mConsole.inputFile.gets() {
			case .str(let s):
				switch CNEscapeCode.decode(string: s) {
				case .ok(let codes):
					for code in codes {
                                                if let str = mReadline.execute(escapeCode: code, console: mConsole, type: mApplication) {
                                                        if !str.isEmpty {
                                                                self.execute(line: str, context: self.mContext, console: mConsole)
                                                                print(string: self.prompt, console: mConsole)
                                                        }
                                                }
					}
				case .error(let err):
					mConsole.error(string: "[Error] " + err.toString() + mNewline)
				@unknown default:
					mConsole.error(string: "[Error] Unknown result" + mNewline)
				}
			case .endOfFile:
				mDoExec = false
			case .null:
				Thread.sleep(forTimeInterval: 0.01)
			@unknown default:
				mConsole.error(string: "Unknown result at \(#function) in \(#file)")
				mConsole.error(string: CNEscapeCode.newline.encode())
			}
		}
		mIsRunning = false
	}

        public func run(scriptAt url: URL, resource res: KEResource, arguments args: Array<CNValue>) {
                switch FileManager.default.checkFileType(pathString: url.path) {
                case .success(let ftype):
                        switch ftype {
                        case .file:
                                run(scriptFile: url, resource: res, arguments: args)
                        case .directory:
                                run(packageDirectory: url, resource: res, arguments: args)
                        @unknown default:
                                CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
                        }
                case .failure(let err):
                        CNLog(logLevel: .error, message: err.toString(), atFunction: #function, inFile: #file)
                }
        }

        public func run(scriptFile url: URL, resource res: KEResource, arguments args: Array<CNValue>) {
		/* allocate the trhread */
		let thread = KLScriptThread(scriptFile: url, resource: res, virtualMachine: mContext.virtualMachine, console: mConsole, environment: mEnvironment, config: mConfig)
		/* start the thread */
		thread.start(arguments: args)
		/* wait until the end */
		while thread.status == .running {
			Thread.sleep(forTimeInterval: 0.01)
		}
		/* put prompt */
		print(string: CNEscapeCode.newline.encode(), console: mConsole)
		print(string: self.prompt, console: mConsole)
	}

        public func run(packageDirectory url: URL, resource res: KEResource, arguments args: Array<CNValue>) {
                let newres = KEResource(packageDirectory: url)
                if let err = newres.loadManifest() {
                        CNLog(logLevel: .error, message: err.toString(), atFunction: #function, inFile: #file)
                        return
                }
                switch self.mainScriptInResource(newres) {
                case .success(let mainfile):
                        let newenv = CNEnvironment(parent: mEnvironment)
                        newenv.setPackageDirectory(path: url.path)

                        let newconf = KEConfig(applicationType: .terminal, doStrict: true, logLevel: mConfig.logLevel)

                        let thread = KLScriptThread(scriptFile: mainfile, resource: newres, virtualMachine: mVirtualMachine, console: mConsole, environment: newenv, config: newconf)

                        /* start the thread */
                        thread.start(arguments: args)

                        /* wait until the end */
                        while thread.status == .running {
                                Thread.sleep(forTimeInterval: 0.1)
                        }
                case .failure(let err):
                        CNLog(logLevel: .error, message: err.toString())
                }
        }

        private func mainScriptInResource(_ res: KEResource) -> Result<URL, NSError> {
                if let url = res.application() {
                        return .success(url)
                } else {
                        let err = NSError.fileError(message: "No application section in resource: \(res.packageDirectory.path())")
                        return .failure(err)
                }
        }

	private func execute(line ln: String, context ctxt: KEContext, console cons: CNFileConsole) {
		let executor = KHExecutor(context: ctxt, console: cons)
		executor.exec(line: ln)
	}

	private func print(string str: String, console cons: CNFileConsole){
		/* I dont know why this interval is required */
		cons.print(string: str)
		Thread.sleep(forTimeInterval: 0.001)
	}
}
