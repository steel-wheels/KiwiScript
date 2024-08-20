/**
 * @file	KLContactDatabase.swift
 * @brief	Define KLContactDatabase class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import CoconutDatabase
import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLContactTable: JSExport
{
	func authorize(_ callback: JSValue)
	func load(_ url: JSValue) -> JSValue
}

@objc public class KLContactDatabase: NSObject, KLContactTable, KLTableProtocol, KLTableCoreProtocol
{
	private var mDatabase: CNContactDatabase
	private var mContext:  KEContext

	public init(context ctxt: KEContext){
		mDatabase = CNContactDatabase()
		mContext  = ctxt
	}

	public func core() -> CNTable {
		return mDatabase
	}

	public var recordCount: JSValue { get {
		return JSValue(int32: Int32(mDatabase.recordCount), in: mContext)
	}}

	public func fieldName(_ idx: JSValue) -> JSValue {
		if let i = valueToInt(value: idx) {
			if let name = mDatabase.fieldName(at: i) {
				return JSValue(object: name, in: mContext)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func fieldNames() -> JSValue {
		var array: Array<NSString> = []
		for field in mDatabase.fieldNames() {
			array.append(field as NSString)
		}
		return JSValue(object: array, in: mContext)
	}

	public func authorize(_ callback: JSValue) {
		mDatabase.authorize(callback: {
			(_ granted: Bool) -> Void in
			if let param = JSValue(bool: granted, in: self.mContext) {
				callback.call(withArguments: [param])
			}
		})
	}

	public func newRecord() -> JSValue {
		let recobj = mDatabase.newRecord()
		let newrec = KLRecord(record: recobj, context: mContext)
		if let newval = KLRecord.allocate(record: newrec) {
			return newval
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func record(_ rowp: JSValue) -> JSValue {
		if rowp.isNumber {
			let row = rowp.toInt32()
			if let rec = mDatabase.record(at: Int(row)) {
				let newrec = KLRecord(record: rec, context: mContext)
				if let newval = KLRecord.allocate(record: newrec) {
					return newval
				} else {
					CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
				}
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func records() -> JSValue {
		var result: Array<JSValue> = []
		for rec in mDatabase.records() {
			let recobj = KLRecord(record: rec, context: mContext)
			if let recval = KLRecord.allocate(record: recobj) {
				result.append(recval)
			}
		}
		return JSValue(object: result, in: mContext)
	}

	public func select(_ nameval: JSValue, _ val: JSValue) -> JSValue {
                var result: Array<JSValue> = []
		if let name = valueToString(value: nameval) {
			let nval = valueToNative(value: val)
                        let recs = mDatabase.select(name: name, value: nval)
                        for rec in recs {
                                let recobj = KLRecord(record: rec, context: mContext)
                                if let recval = KLRecord.allocate(record: recobj) {
                                        result.append(recval)
                                }
                        }
		} else {
			CNLog(logLevel: .error, message: "Invalid type for field name", atFunction: #function, inFile: #file)
		}
                return JSValue(object: result, in: mContext)
	}

	public var current: JSValue { get {
		if let rec = mDatabase.current {
			let recval = KLRecord(record: rec, context: mContext)
			if let result = KLRecord.allocate(record: recval) {
				return result
			}
		}
		return JSValue(nullIn: mContext)
	}}

	public func search(_ val: JSValue, _ field: JSValue) -> JSValue {
		if field.isString {
			if let fname = field.toString() {
				let conv = KLScriptValueToNativeValue()
				let nval = conv.convert(scriptValue: val)
				let recs = mDatabase.search(value: nval, forField: fname)
				let objs = recs.map({(_ rec: CNRecord) -> KLRecord in return KLRecord(record: rec, context: mContext)})
				if let res = KLRecord.allocate(records: objs, context: mContext) {
					return res
				} else {
					CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
				}
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func append(_ rcdp: JSValue) {
		if rcdp.isObject {
			if let rec = rcdp.toObject() as? KLRecord {
				mDatabase.append(record: rec.core())
				return
			}
		}
		CNLog(logLevel: .error, message: "Unexpected record object", atFunction: #function, inFile: #file)
	}


	public func remove(_ rcd: JSValue) -> JSValue {
		CNLog(logLevel: .error, message: "Not supported yet", atFunction: #function, inFile: #file)
		return JSValue(bool: false, in: mContext)
	}

	public func load(_ urlp: JSValue) -> JSValue {
		/*
		var result = false
		if urlp.isNull {
			let dc = CNContactDatabase.shared
			switch dc.load(fromURL: nil) {
			case .ok:
				result = true
			case .error(let err):
				CNLog(logLevel: .error, message: err.description, atFunction: #function, inFile: #file)
			@unknown default:
				CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			}
		} else if let url = urlp.toURL() {
			let dc = CNContactDatabase.shared
			switch dc.load(fromURL: url) {
			case .ok:
				result = true
			case .error(let err):
				CNLog(logLevel: .error, message: err.description, atFunction: #function, inFile: #file)
			@unknown default:
				CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			}
		}
		return JSValue(bool: result, in: mContext)*/
		return JSValue(nullIn: mContext)
	}

	//public func save() -> JSValue {
	//	CNLog(logLevel: .error, message: "Not supported yet", atFunction: #function, inFile: #file)
	//	return JSValue(bool: false, in: mContext)
	//}

	public func forEach(_ callback: JSValue) {
		mDatabase.forEach(callback: {
			(_ record: CNRecord) -> Void in
			let recobj = KLRecord(record: record, context: mContext)
			if let recval = KLRecord.allocate(record: recobj) {
				callback.call(withArguments: [recval])
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
			}
		})
	}

	private func valueToNative(value val: JSValue) -> CNValue {
		let conv = KLScriptValueToNativeValue()
		return conv.convert(scriptValue: val)
	}

	private func valueToString(value val: JSValue) -> String? {
		if val.isString {
			return val.toString()
		} else {
			return nil
		}
	}

	private func valueToInt(value val: JSValue) -> Int? {
		if val.isNumber {
			if let num = val.toNumber() {
				return num.intValue
			}
		}
		return nil
	}
}


