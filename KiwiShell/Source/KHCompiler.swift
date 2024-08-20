/**
 * @file	KHCompiler.swift
 * @brief	Define KHCompiler class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

open class KHLibraryCompiler: KLLibraryCompiler
{
	open override func compile(context ctxt: KEContext, resource res: KEResource, console  cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {

		/* Compile base library */
		guard super.compile(context: ctxt, resource: res, console: cons, environment: env, config: conf) else {
			CNLog(logLevel: .error, message: "Failed to compile KiwiLibrary")
			return false
		}

		/* Compile built in function */
        /*
		if !compileBuiltinFunctions(context: ctxt, environment: env, console: cons) {
			CNLog(logLevel: .error, message: "Failed to pepare builtin function")
			return false
		}*/

		return true
	}

    /*
	private func compileBuiltinFunctions(context ctxt: KEContext, environment env: CNEnvironment, console cons: CNFileConsole) -> Bool {
		let srcfiles: Array<String> = [
			"clear-func"
		]
		let conf = KEConfig(applicationType: .terminal, doStrict: true, logLevel: .defaultLevel)
		for srcfile in srcfiles {
			if let url = CNFilePath.URLForResourceFile(fileName: srcfile, fileExtension: "js", subdirectory: "Library", forClass: KHLibraryCompiler.self) {
				if let scr = url.loadContents() as? String {
					let _ = compileStatement(context: ctxt, statement: scr, sourceFile: url, console: cons, config: conf)
				} else {
					cons.error(string: "Failed to load file: \(srcfile).js\n")
				}
			} else {
				cons.error(string: "Built-in script \"Library/\(srcfile).js\" is not found.\n")
			}
		}
		return true
	}*/

	private func valueToValue(_ val: JSValue) -> CNValue {
		let conv = KLScriptValueToNativeValue()
		return conv.convert(scriptValue: val)
	}

	private func valueToFile(_ val: JSValue) -> CNFile? {
		if let obj = val.toObject() as? KLFile {
			return obj.core
		} else {
			return nil
		}
	}
}

