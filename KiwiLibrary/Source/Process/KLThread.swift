/**
 * @file	KLThread.swift
 * @brief	Define KLThread class
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLThreadProtocol: JSExport
{
	func start(_ args: JSValue)
	var status:   	JSValue	{ get }
	var exitCode:   JSValue	{ get }
}

open class KLScriptThread: CNThread
{
	private var mContext:		KEContext
	private var mResource:		KEResource
	private var mConfig:		KEConfig
	private var mSourceFile:	URL
	private var mScript:		String
	private var mDidCompiled:	Bool

	public init(scriptFile scrurl: URL, resource res: KEResource, virtualMachine vm: JSVirtualMachine?, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) {
		mSourceFile = scrurl
		mContext    = KEContext(virtualMachine: vm ?? JSVirtualMachine())
		mResource   = res
		if let scr = scrurl.loadContents() {
			mScript = scr as String
		} else {
			CNLog(logLevel: .error, message: "Failed to load script from \(scrurl.path) (1)", atFunction: #function, inFile: #file)
			mScript = ""
		}
		mConfig      = conf
		mDidCompiled = false
		super.init(console: cons, environment: env)

		/* set application directory to environment */
		self.environment.setPackageDirectory(path: mResource.packageDirectory.path)
	}

	open override func start(arguments args: Array<CNValue>) {
		if !mDidCompiled {
			if !self.compile(context: mContext, resource: mResource, console: super.console, environment: super.environment, config: mConfig) {
				CNLog(logLevel: .error, message: "Failed to compile library", atFunction: #function, inFile: #file)
			}
			mDidCompiled = true
		}
		super.start(arguments: args)
	}

	open func compile(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		let compiler = KLLibraryCompiler()
		if compiler.compile(context: mContext, resource: mResource, console: super.console, environment: super.environment, config: mConfig) {
			return true
		} else {
			CNLog(logLevel: .error, message: "Failed to compile library", atFunction: #function, inFile: #file)
			return false
		}
	}

	public override func mainFunction(arguments args: Array<CNValue>, environment env: CNEnvironment) -> CNExitCode {
		if !mScript.isEmpty {
			/* Compile the script */
			let runner = KECompiler()
			if let _ = runner.compileStatement(context: mContext, statement: mScript, sourceFile: mSourceFile, console: console, config: mConfig) {
				/* Call main function */
				if let mainfunc = mContext.get(name: "main") {
					/* make argument objects */
					let converter = CNValueToAnyObject()
					var jsargs: Array<AnyObject> = []
					for arg in args {
						let argobj = converter.convert(value: arg)
						jsargs.append(argobj)
					}
					/* Call main function */
					if let retval = mainfunc.call(withArguments: jsargs) {
						return CNExitCode.fromValue(value: retval)
					} else {
						self.console.error(string: "Failed to call main function\n")
					}
				} else {
					self.console.error(string: "The main function is NOT found\n")
				}
				return .compileError
			} else {
				return .runtimeError
			}
		} else {
			CNLog(logLevel: .error, message: "Failed to load script from \(mSourceFile.path)", atFunction: #function, inFile: #file)
			return .fileError
		}
	}
}

@objc open class KLThread: NSObject, KLThreadProtocol
{
	private var mThread:	CNThread
	private var mContext:	KEContext

	public var core: CNThread { get { return mThread }}

	public init(thread thrd: CNThread, context ctxt: KEContext) {
		mThread	 = thrd
		mContext = ctxt
	}

	public var status: JSValue { get {
		let status: Int32 =  Int32(mThread.status.rawValue)
		return JSValue(int32: status, in: mContext)
	}}

	public var exitCode: JSValue { get {
		let ecode: Int32 =  Int32(mThread.exitCode.rawValue)
		return JSValue(int32: ecode, in: mContext)
	}}

	public func start(_ arg: JSValue) {
		let conv = KLScriptValueToNativeValue()
		let narg = conv.convert(scriptValue: arg)
		switch narg {
		case .arrayValue(let nelms):
			mThread.start(arguments: nelms)
		default:
			CNLog(logLevel: .error, message: "Failed to convert argument to array", atFunction: #function, inFile: #file)
			mThread.start(arguments: [narg])
		}
	}
}
