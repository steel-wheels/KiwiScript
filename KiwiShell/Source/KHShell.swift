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
        private var mReadline:		CNReadline
	private var mVirtualMachine:	JSVirtualMachine
	private var mContext:		KEContext
	private var mEnvironment:	CNEnvironment
	private var mConfig:		KEConfig
	private var mNewline:		String

	public var prompt: String { get {
		return mPromptBase +  "$ "
	}}

	public init(application aptype: CNApplicationType, console cons: CNFileConsole) {
                mApplication	= aptype == .terminal ? .terminal : .window
		mConsole	= cons
		mPromptBase	= "js"
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
                while true {
                        var doexec = true
                        print(string: self.prompt, console: mConsole)
                        while doexec {
                                doexec = mReadline.execute(executionFunction: {
                                        (_ str: String) -> Void in
                                        self.execute(line: str, context: mContext, console: mConsole)
                                }, console: mConsole, applicationType: mApplication)
                        }
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
