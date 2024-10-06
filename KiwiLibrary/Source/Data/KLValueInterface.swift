/**
 * @file	KLValueInterface.swift
 * @brief	Extend CNValueInterface class
 * @par Copyright
 *   Copyright (C) 2022-2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

private let sharedUniqueIdentifier = CNUniqueIdentifier(identifier: "_kiwilibrary_ifval_temp_var")

@objc public protocol KLInterfaceValueProtocol: JSExport
{
	var fieldCount:		JSValue { get }
	var fieldNames:		JSValue { get }

	func value(_ name: JSValue) -> JSValue
	func setValue(_ val: JSValue, _ name: JSValue) -> JSValue
}

@objc public class KLInterfaceValue: NSObject, KLInterfaceValueProtocol
{
	private var mCore: 	CNInterfaceValue
	private var mContext:	KEContext

	static func allocate(interfaceValue core: CNInterfaceValue, context ctxt: KEContext) -> JSValue {
		let ifobj = KLInterfaceValue(interfaceValue: core, context: ctxt)
		guard let ifval = JSValue(object: ifobj, in: ctxt) else {
			CNLog(logLevel: .error, message: "allocate object failed", atFunction: #function, inFile: #file)
			return JSValue(undefinedIn: ctxt)
		}

                let varname = CNUniqueIdentifier.identifier(in: sharedUniqueIdentifier)

		ctxt.set(name: varname, value: ifval)

		var script = ""
		let pnames: Array<String> = core.values.map{ $0.key }
		for prop in pnames {
			script +=   "Object.defineProperty(\(varname), \"\(prop)\", {\n"
				  + "  get()    { return this.value(\"\(prop)\") ;   },\n"
				  + "  set(val) { this.setValue(val, \"\(prop)\") ;  }\n"
				  + "}) ;\n"
		}
		let _ = ctxt.evaluateScript(script: script, sourceFile: URL(fileURLWithPath: #file))
		if ctxt.errorCount == 0 {
			return ifval
		} else {
			ctxt.resetErrorCount()
			CNLog(logLevel: .error, message: "execute method failed: \(script)", atFunction: #function, inFile: #file)
			return JSValue(undefinedIn: ctxt)
		}
	}

	public init(interfaceValue core: CNInterfaceValue, context ctxt: KEContext) {
		mCore		= core
		mContext	= ctxt
	}

	public var core: CNInterfaceValue { get {
		return mCore
	}}

	public var fieldCount: JSValue { get {
		return JSValue(int32: Int32(mCore.values.count), in: mContext)
	}}

	public var fieldNames: JSValue { get {
		let names: Array<String> = mCore.values.map{ $0.key }
		return JSValue(object: names, in: mContext)
	}}

	public func value(_ nameval: JSValue) -> JSValue {
		if let name = nameval.toString() {
			if let val = mCore.get(name: name) {
				return val.toJSValue(context: mContext)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func setValue(_ val: JSValue, _ nameval: JSValue) -> JSValue {
		if let name = nameval.toString() {
			let converter = KLScriptValueToNativeValue()
			let nval = converter.convert(scriptValue: val)
			mCore.set(name: name, value: nval)
			return JSValue(bool: true, in: mContext)
		} else {
			return JSValue(bool: false, in: mContext)
		}
	}
}

public extension CNInterfaceValue
{
	static func interfaceName(scriptValue val: JSValue) -> String? {
		if let ifval = val.toObject() as? KLInterfaceValue {
			return ifval.core.type.name
		} else {
			return nil
		}
	}

	static func isInterface(scriptValue val: JSValue) -> Bool {
		if let _ = val.toObject() as? KLInterfaceValue {
			return true
		} else {
			return false
		}
	}

	static func fromJSValue(scriptValue val: JSValue) -> Result<CNInterfaceValue, NSError> {
		if let obj = val.toObject() as? KLInterfaceValue {
			return .success(obj.core)
		} else {
			let err = NSError.parseError(message: "Failed to convert to interface value")
			return .failure(err)
		}
	}

	static func fromJSValue(interfaceType iftype: CNInterfaceType, values vals: Dictionary<String, Any>) -> Result<CNInterfaceValue, NSError> {
		var values: Dictionary<String, CNValue> = [:]
		let converter = CNAnyObjecToValue()
		for (key, elm) in vals {
			values[key] = converter.convert(anyObject: elm as AnyObject)
		}
		let ifval = CNInterfaceValue(types: iftype, values: values)
		return .success(ifval)
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		let obj = KLInterfaceValue.allocate(interfaceValue: self, context: ctxt)
		return JSValue(object: obj, in: ctxt)
	}
}
