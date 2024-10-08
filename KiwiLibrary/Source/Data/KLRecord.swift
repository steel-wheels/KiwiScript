/**
 * @file	KLRecord.swift
 * @brief	Define KLRecord class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

private let sharedUniqueIdentifier = CNUniqueIdentifier(identifier: "_kiwilibrary_record_temp_var")

@objc public protocol KLRecordProtocol: JSExport
{
	var fieldCount:		JSValue { get }
	var fieldNames:		JSValue { get }

	func value(_ name: JSValue) -> JSValue
	func setValue(_ val: JSValue, _ name: JSValue) -> JSValue
}

public protocol KLRecordCoreProtocol
{
	func core() -> CNRecord
}

@objc public class KLRecord: NSObject, KLRecordProtocol, KLRecordCoreProtocol
{
	public static let ScriptInterfaceName = "RecordIF"

	private var mRecord:	CNRecord
	private var mContext:	KEContext

	public init(record rcd: CNRecord, context ctxt: KEContext){
		mRecord		= rcd
		mContext	= ctxt
		super.init()
	}

	public static func allocate(record rcd: KLRecord) -> JSValue? {
		let context = rcd.mContext
		guard let rcdval = JSValue(object: rcd, in: context) else {
			CNLog(logLevel: .error, message: "allocate object failed", atFunction: #function, inFile: #file)
			return nil
		}
                let rcdname = CNUniqueIdentifier.identifier(in: sharedUniqueIdentifier)
		context.set(name: rcdname, value: rcdval)

		var script = ""
		for prop in rcd.core().fieldNames {
			script +=   "Object.defineProperty(\(rcdname), \"\(prop)\", {\n"
				  + "  get()    { return this.value(\"\(prop)\") ;   },\n"
				  + "  set(val) { this.setValue(val, \"\(prop)\") ;  }\n"
				  + "}) ;\n"
		}
		let _ = context.evaluateScript(script: script, sourceFile: URL(fileURLWithPath: #file))
		if context.errorCount == 0 {
			return rcdval
		} else {
			context.resetErrorCount()
			CNLog(logLevel: .error, message: "execute method failed: \(script)", atFunction: #function, inFile: #file)
			return nil
		}
	}

	public static func allocate(records rcds: Array<KLRecord>, context ctxt: KEContext) -> JSValue? {
		guard let result = JSValue(newArrayIn: ctxt) else {
			CNLog(logLevel: .error, message: "Failed to allocate array", atFunction: #function, inFile: #file)
			return nil
		}
		let resname = CNUniqueIdentifier.identifier(in: sharedUniqueIdentifier)
		ctxt.set(name: resname, value: result)
		for rec in rcds {
			if let elmval = allocate(record: rec) {
				let elmname = CNUniqueIdentifier.identifier(in: sharedUniqueIdentifier)
				ctxt.set(name: elmname, value: elmval)
				let script = "\(resname).push(\(elmname)) ;\n"
				let _ = ctxt.evaluateScript(script: script, sourceFile: URL(fileURLWithPath: #file))
				if ctxt.errorCount != 0 {
					ctxt.resetErrorCount()
					CNLog(logLevel: .error, message: "push method failed: \(script)", atFunction: #function, inFile: #file)
					return JSValue(nullIn: ctxt)
				}
			} else {
				CNLog(logLevel: .error, message: "Failed to allocation", atFunction: #function, inFile: #file)
				return nil
			}
		}
		return result
	}

	public func core() -> CNRecord {
		return mRecord
	}

	public var fieldCount: JSValue { get {
		return JSValue(int32: Int32(mRecord.fieldCount), in: mContext)
	}}

	public var fieldNames: JSValue { get {
		return JSValue(object: mRecord.fieldNames, in: mContext)
	}}

	public func value(_ name: JSValue) -> JSValue {
		if name.isString {
			if let nstr = name.toString() {
				if let val = mRecord.value(ofField: nstr) {
					let result = val.toJSValue(context: mContext)
					return result
				}
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func setValue(_ val: JSValue, _ name: JSValue) -> JSValue {
		if name.isString {
			if let nstr = name.toString() {
				let conv = KLScriptValueToNativeValue()
				CNExecuteInMainThread(doSync: false, execute: {
					() -> Void in
					if !self.mRecord.setValue(value: conv.convert(scriptValue: val), forField: nstr) {
						CNLog(logLevel: .error, message: "Failed to set value", atFunction: #function, inFile: #file)
					}
				})
			}
		} else {
			CNLog(logLevel: .error, message: "Invalid type of name", atFunction: #function, inFile: #file)
		}
		return JSValue(nullIn: mContext)
	}
}

