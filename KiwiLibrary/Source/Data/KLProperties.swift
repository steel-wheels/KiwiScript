/**
 * @file	KLProperties.swift
 * @brief	Define KLProperties class
 * @par Copyright
 *   Copyright (C) 2023  Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLPropertiesProtocol: JSExport
{
	var count:  JSValue { get }				// -> number
	var names:  JSValue { get }				// -> string[]

	func value(_ name: JSValue) -> JSValue			// values(name: string): void
	func set(_ value: JSValue, _ name: JSValue) -> JSValue	// set(value: any, name: string)
}

@objc public class KLProperties: NSObject, KLPropertiesProtocol, KLEmbeddedObject
{
	private var mProperties: CNProperties
	private var mContext:    KEContext

	private static let TEMPORARY_VARIABLE_NAME = "_kiwilibrary_properties_temp_var"
	private static var temporary_variable_id   = 0

	public init(properties prop: CNProperties, context ctxt: KEContext){
		mProperties = prop
		mContext    = ctxt
	}

	public func core() -> CNProperties {
		return mProperties
	}

	public static func allocate(properties props: KLProperties) -> JSValue? {
		let context = props.mContext
		guard let propsval = JSValue(object: props, in: context) else {
			CNLog(logLevel: .error, message: "allocate object failed", atFunction: #function, inFile: #file)
			return nil
		}
		let propsname = temporaryVariableName()
		context.set(name: propsname, value: propsval)

		var script = ""
		for prop in props.core().names {
			script +=   "Object.defineProperty(\(propsname), \"\(prop)\", {\n"
				  + "  get()    { return this.value(\"\(prop)\") ;   },\n"
				  + "  set(val) { this.set(val, \"\(prop)\") ;  }\n"
				  + "}) ;\n"
		}
		let _ = context.evaluateScript(script: script, sourceFile: URL(fileURLWithPath: #file))
		if context.errorCount == 0 {
			return propsval
		} else {
			context.resetErrorCount()
			CNLog(logLevel: .error, message: "execute method failed: \(script)", atFunction: #function, inFile: #file)
			return nil
		}
	}

	private static func temporaryVariableName() -> String {
		let result = "\(KLProperties.TEMPORARY_VARIABLE_NAME)_\(KLProperties.temporary_variable_id)"
		KLProperties.temporary_variable_id += 1
		return result
	}

	public var count: JSValue { get {
		return JSValue(int32: Int32(mProperties.count), in: mContext)
	}}

	public var names: JSValue { get {
		return JSValue(object: mProperties.names, in: mContext)
	}}

	public func value(_ name: JSValue) -> JSValue {
		if let str = name.toString() {
			if let val = mProperties.value(byName: str) {
				return val.toJSValue(context: mContext)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func set(_ value: JSValue, _ name: JSValue) -> JSValue {
		let result: Bool
		if let str = name.toString() {
			let conv = KLScriptValueToNativeValue()
			let nval = conv.convert(scriptValue: value)
			mProperties.set(value: nval, forName: str)
                        result = true
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func copy(context ctxt: KiwiEngine.KEContext) -> KLEmbeddedObject {
		return KLProperties(properties: mProperties, context: ctxt)
	}


}

