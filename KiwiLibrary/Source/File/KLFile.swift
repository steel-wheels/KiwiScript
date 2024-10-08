/**
 * @file	KLFile.swift
 * @brief	Define KLFile class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLFileProtocol: JSExport
{
	func getc() -> JSValue
	func getl() -> JSValue
	func put(_ str: JSValue) -> JSValue
	func close()
}

@objc public class KLFile: NSObject, KLFileProtocol
{
	public static let StdInName	= "_stdin"
	public static let StdOutName	= "_stdout"
	public static let StdErrName	= "_stderr"

	private var mFile:	CNFile
	private var mContext:	KEContext
	private var mNullValue:	JSValue

	public init(file fl: CNFile, context ctxt: KEContext){
		mFile    	= fl
		mContext 	= ctxt
		mNullValue	= JSValue(nullIn: ctxt)
	}

	public var core: CNFile {
		get { return mFile }
	}

	public var fileHandle: FileHandle {
		get { return mFile.fileHandle }
	}

	private func endOfFile() -> JSValue {
		return JSValue(object: CNFile.EOF, in: mContext)
	}

	public func getc() -> JSValue {
		let result: JSValue
		switch mFile.getc() {
		case .char(let c):
			result = JSValue(object: String(c), in: mContext)
		case .endOfFile:
			result = self.endOfFile()
		case .null:
			result = mNullValue
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			result = self.endOfFile()
		}
		return result
	}

	public func getl() -> JSValue {
		let result: JSValue
		switch mFile.getl() {
		case .line(let str):
			result = JSValue(object: str, in: mContext)
		case .endOfFile:
			result = self.endOfFile()
		case .null:
			result = mNullValue
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			result = self.endOfFile()
		}
		return result
	}

	public func put(_ strval: JSValue) -> JSValue {
		var result: Int32 = 0
		if strval.isString {
			if let str = strval.toString() {
				mFile.put(string: str)
				result = Int32(str.lengthOfBytes(using: .utf8))
			}
		}
		return JSValue(int32: result, in: mContext)
	}

	public func close(){
		mFile.close()
	}
}

