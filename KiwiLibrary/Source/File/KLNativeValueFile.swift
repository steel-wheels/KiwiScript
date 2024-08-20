/**
 * @file	KSNativeValueFile.swift
 * @brief	Define KSNativeValueFile class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

@objc public protocol KLNativeValueFileProtocol: JSExport
{
	func read(_ file: JSValue) -> JSValue
	func write(_ file: JSValue, _ json: JSValue) -> JSValue
}

@objc public class KLNativeValueFile: NSObject, KLNativeValueFileProtocol
{
	private var mContext: KEContext

	public init(context ctxt: KEContext){
		mContext = ctxt
	}

	public func read(_ file: JSValue) -> JSValue {
		if file.isObject {
			if let fileobj = file.toObject() as? KLFile {
				let text   = getall(file: fileobj.core)
				let parser = CNValueParser()
				switch parser.parse(source: text) {
				case .success(let val):
					return val.toJSValue(context: mContext)
				case .failure(let err):
					CNLog(logLevel: .error, message: "[Error] \(err.toString())", atFunction: #function, inFile: #file)
				}
			}
		}
		return JSValue(nullIn: mContext)
	}

	private func getall(file fp: CNFile) -> String {
		var allstr: String = ""
		var docont = true
		while docont {
			switch fp.gets() {
			case .null:
				break
			case .endOfFile:
				docont = false
			case .str(let str):
				allstr += str
			@unknown default:
				CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
				docont = false
			}
		}
		return allstr
	}

	public func write(_ file: JSValue, _ json: JSValue) -> JSValue {
		var result = false
		if let fileobj = file.toObject() as? KLFile {
			let conv = KLScriptValueToNativeValue()
			let nval = conv.convert(scriptValue: json)
			let text = nval.toScript().toStrings().joined(separator: "\n")
			fileobj.core.put(string: text)
			result = true
		}
		return JSValue(bool: result, in: mContext)
	}
}

