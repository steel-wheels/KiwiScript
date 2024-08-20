/**
 * @file	KLNativeValue.swift
 * @brief	Extend CNValue class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import CoconutDatabase
import JavaScriptCore
import Foundation

extension CNValue
{
	public func toJSValue(context ctxt: KEContext) -> JSValue {
		let result: JSValue
		switch self {
		case .boolValue(let val):
			result = JSValue(bool: val, in: ctxt)
		case .numberValue(let val):
			result = JSValue(object: val, in: ctxt)
		case .stringValue(let val):
			result = JSValue(object: val, in: ctxt)
		case .enumValue(let eval):
			result = eval.toJSValue(context: ctxt)
		case .arrayValue(let arr):
			result = arrayToValue(value: arr, context: ctxt)
		case .setValue(let vset):
			result = arrayToValue(value: vset, context: ctxt)
		case .dictionaryValue(let val):
			result = dictionaryToValue(value: val, context: ctxt)
		case .interfaceValue(let val):
			result = val.toJSValue(context: ctxt)
		case .objectValue(let val):
			result = JSValue(object: val, in: ctxt)
		@unknown default:
			CNLog(logLevel: .error, message: "Undefine type value", atFunction: #function, inFile: #file)
			result = JSValue(nullIn: ctxt)
		}
		return result
	}

	private func arrayToValue(value arr: Array<CNValue>, context ctxt: KEContext) -> JSValue {
		var newarr: Array<AnyObject> = []
		let converter = CNValueToAnyObject()
		for elm in arr {
			let obj = converter.convert(value: elm)
			newarr.append(obj)
		}
		if let newval = JSValue(object: newarr, in: ctxt) {
			return newval
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate value", atFunction: #function, inFile: #file)
			return JSValue(nullIn: ctxt)
		}
	}

	private func dictionaryToValue(value dict: Dictionary<String, CNValue>, context ctxt: KEContext) -> JSValue {
		var newdict: Dictionary<String, AnyObject> = [:]
		let converter = CNValueToAnyObject()
		for (key, elm) in dict {
			newdict[key] = converter.convert(value: elm)
		}
		if let newval = JSValue(object: newdict, in: ctxt) {
			return newval
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate value", atFunction: #function, inFile: #file)
			return JSValue(nullIn: ctxt)
		}
	}
}

