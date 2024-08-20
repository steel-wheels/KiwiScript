/**
 * @file	KLStringStream.swift
 * @brief	Extend KLStringStream class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLStringStreamProtocol: JSExport
{
	func getc() -> JSValue
	func gets(_ count: JSValue) -> JSValue
	func getl() -> JSValue
	func getident() -> JSValue
	func getword() -> JSValue
	func getint() -> JSValue
	func ungetc() -> JSValue
	func reqc(_ c: JSValue) -> JSValue
	func peek(_ count: JSValue) -> JSValue
	func skip(_ count: JSValue)
	func skipSpaces()
	func eof() -> JSValue
}

@objc public class KLStringStream: NSObject, KLStringStreamProtocol
{
	private var mStringStream: 	CNStringStream
	private var mContext:		KEContext

	public init(string str: String, context ctxt: KEContext) {
		mStringStream = CNStringStream(string: str)
		mContext      = ctxt
	}

	public func getc() -> JSValue {
		if let c = mStringStream.getc() {
			return JSValue(object: "\(c)", in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func gets(_ count: JSValue) -> JSValue {
		guard let cnt = valueToInt(value: count) else {
			CNLog(logLevel: .error, message: "Invalid parameter type", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
		if let str = mStringStream.gets(count: cnt) {
			return JSValue(object: str, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func getl() -> JSValue {
		if let str = mStringStream.getl() {
			return JSValue(object: str, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func getident() -> JSValue {
		if let str = mStringStream.getident() {
			return JSValue(object: str, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}

	}

	public func getword() -> JSValue {
		if let str = mStringStream.getword() {
			return JSValue(object: str, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func getint() -> JSValue {
		if let num = mStringStream.getint() {
			return JSValue(int32: Int32(num), in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func ungetc() -> JSValue {
		if let c = mStringStream.ungetc() {
			return JSValue(object: "\(c)", in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func reqc(_ val: JSValue) -> JSValue {
		var result: Bool = false
		if val.isString {
			if let str = val.toString() {
				if mStringStream.reqc(str) {
					result = true
				}
			}
		}
		return JSValue(bool: result, in: mContext)
	}

	public func peek(_ count: JSValue) -> JSValue {
		guard let cnt = valueToInt(value: count) else {
			CNLog(logLevel: .error, message: "Invalid parameter type", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
		if let c = mStringStream.peek(offset: cnt) {
			return JSValue(object: "\(c)", in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func skip(_ count: JSValue) {
		guard let cnt = valueToInt(value: count) else {
			CNLog(logLevel: .error, message: "Invalid parameter type", atFunction: #function, inFile: #file)
			return
		}
		mStringStream.skip(count: cnt)
	}

	public func skipSpaces() {
		mStringStream.skipspaces()
	}

	public func eof() -> JSValue {
		let result = mStringStream.eof()
		return JSValue(bool: result, in: mContext)
	}

	private func valueToInt(value val: JSValue) -> Int? {
		if val.isNumber {
			return val.toNumber().intValue
		} else {
			return nil
		}
	}
}

