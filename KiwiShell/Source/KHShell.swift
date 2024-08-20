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
	private var mApplication:	KEApplicationType
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

	public init(application aptype: KEApplicationType, console cons: CNFileConsole) {
		mApplication	= aptype
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
						execute(escapeCode: code, context: mContext, console: mConsole)
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

	private func execute(escapeCode ecode: CNEscapeCode, context ctxt: KEContext, console cons: CNFileConsole){
		/* decode the command */
		//NSLog("ecode = \(ecode.description())")
		switch ecode {
		case .string(let str):
			mReadline.insert(string: str)
			let ins: CNEscapeCode = .insertSpace(str.count)
			print(string: ins.encode(), console: cons)
			print(string: ecode.encode(), console: cons)
		case .delete:
			if mReadline.delete() {
				switch mApplication {
				case .terminal:
					let bs = CNEscapeCode.backspace.encode()
					print(string: bs,  console: cons)
					print(string: " ", console: cons)
					print(string: bs,  console: cons)
				default:
					let dcode: CNEscapeCode = .delete
					print(string: dcode.encode(), console: cons)
				}
			}
		case .newline:
			print(string: ecode.encode(), console: cons)
			/* execute the command */
			if !mReadline.isEmpty {
				execute(line: mReadline.line, context: ctxt, console: cons)
				mReadline.clear()
			}
			print(string: self.prompt, console: cons)
		case .cursorForward(let num):
			let delta = mReadline.cursorForward(num)
			if delta > 0 {
				let newcode: CNEscapeCode = .cursorForward(delta)
				print(string: newcode.encode(), console: cons)
			}
		case .cursorBackward(let num):
			let delta = mReadline.cursorBackward(num)
			if delta > 0 {
				let newcode: CNEscapeCode = .cursorBackward(delta)
				print(string: newcode.encode(), console: cons)
			}
		default:
			print(string: ecode.encode(), console: cons)
		}
	}

	public func run(scriptAt url: URL, resource res: KEResource, arguments args: Array<CNValue>) {
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
