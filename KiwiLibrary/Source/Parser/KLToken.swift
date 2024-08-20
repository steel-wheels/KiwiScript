/**
 * @file	KLToken.swift
 * @brief	Define KLToken class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

@objc public protocol KLTokenProtocol: JSExport
{
	var type:	JSValue { get }
	var lineNo:	JSValue { get }

	func reservedWord() -> JSValue
	func symbol() -> JSValue
	func identifier() -> JSValue
	func bool() -> JSValue
	func int() -> JSValue
	func float() -> JSValue
	func text() -> JSValue
}

@objc public class KLToken: NSObject, KLTokenProtocol
{
	private var mToken:	CNToken
	private var mContext:	KEContext

	public init(source tkn: CNToken, context ctxt: KEContext){
		mToken   = tkn
		mContext = ctxt
	}

	public var type: JSValue { get {
		let etype = CNTokenId.from(tokenType: mToken.type)
		return JSValue(int32: Int32(etype.rawValue), in: mContext)
	}}

	public var lineNo: JSValue { get {
		return JSValue(int32: Int32(mToken.lineNo), in: mContext)
	}}

	public func reservedWord() -> JSValue {
		return nullableIntValue(value: mToken.getReservedWord())
	}

	public func symbol() -> JSValue {
		return nullableCharacterValue(value: mToken.getSymbol())
	}

	public func identifier() -> JSValue {
		return nullableStringValue(value: mToken.getIdentifier())
	}

	public func bool() -> JSValue {
		return nullableBoolValue(value: mToken.getBool())
	}

	public func int() -> JSValue {
		let result: JSValue
		switch mToken.type {
		case .IntToken(let val):
			result = JSValue(object: NSNumber(value: val), in: mContext)
		case .UIntToken(let val):
			result = JSValue(object: NSNumber(value: val), in: mContext)
		default:
			result = JSValue(nullIn: mContext)
		}
		return result
	}

	public func float() -> JSValue {
		return nullableDoubleValue(value: mToken.getDouble())
	}

	public func text() -> JSValue {
		let result: JSValue
		switch mToken.type {
		case .StringToken(let str):
			result = JSValue(object: str, in: mContext)
		case .TextToken(let str):
			result = JSValue(object: str, in: mContext)
		case .CommentToken(let str):
			result = JSValue(object: str, in: mContext)
		default:
			result = JSValue(nullIn: mContext)
		}
		return result
	}

	private func nullableStringValue(value val: String?) -> JSValue {
		if let sval = val {
			return JSValue(object: sval, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	private func nullableCharacterValue(value val: Character?) -> JSValue {
		if let cval = val {
			return JSValue(object: String(cval), in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	private func nullableIntValue(value val: Int?) -> JSValue {
		if let ival = val {
			return JSValue(int32: Int32(ival), in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	private func nullableBoolValue(value val: Bool?) -> JSValue {
		if let bval = val {
			return JSValue(bool: bval, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	private func nullableDoubleValue(value val: Double?) -> JSValue {
		if let ival = val {
			return JSValue(double: ival, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public static func stringToToken(_ strval: JSValue, context ctxt: KEContext) -> JSValue
	{
		guard strval.isString else {
			CNLog(logLevel: .error, message: "Invalid 1st parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: ctxt)
		}
		guard let str = strval.toString() else {
			CNLog(logLevel: .error, message: "Invalid 1st parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: ctxt)
		}

		let result: JSValue
        let config = CNParserConfig(ignoreComments: true, allowIdentiferHasPeriod: false)
		switch CNStringToToken(string: str, config: config) {
		case .success(let tokens):
			let tokenobjs: Array<KLToken> = tokens.map { KLToken(source: $0, context: ctxt) }
			return JSValue(object: tokenobjs, in: ctxt)
		case .failure(let err):
			CNLog(logLevel: .error, message: err.toString(), atFunction: #function, inFile: #file)
			result = JSValue(nullIn: ctxt)
		}
		return result
	}
}

