/**
 * @file	KLTable.swift
 * @brief	Define KLTable class
 * @par Copyright
 *   Copyright (C) 2021-2022 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

@objc public protocol KLTableProtocol: JSExport
{
	var recordCount: JSValue { get }

	func fieldName(_ idx: JSValue) -> JSValue		// idx:number, return: string
	func fieldNames() -> JSValue				// return: string[]
	func select(_ val: JSValue, _ name: JSValue) -> JSValue	// (any, string): boolean
	func remove(_ row: JSValue) -> JSValue			// (row: number): boolean

	func newRecord() -> JSValue				// return: RecordIF
	func record(_ row: JSValue) -> JSValue			// (row: number): RecordIF
	func records() -> JSValue				// return array<RecordIF>
	var current: JSValue { get }

	func append(_ rcd: JSValue)					// (record: RecordIF)
}

public protocol KLTableCoreProtocol
{
	func core() -> CNTable
}

@objc open class KLTable: NSObject, KLTableProtocol, KLTableCoreProtocol
{
	private var mTable: 	CNTable
	private var mContext:	KEContext

	private static func valueToURL(value val: JSValue) -> URL? {
		if val.isObject {
			if let obj = val.toObject() as? KLURL {
				return obj.url
			}
		}
		return nil
	}

	public init(table tbl: CNTable, context ctxt: KEContext){
		mTable		= tbl
		mContext	= ctxt
	}

	public var recordCount: JSValue { get {
		return JSValue(int32: Int32(mTable.recordCount), in: mContext)
	}}

	public var context: KEContext { get {
		return mContext
	}}

	public func core() -> CNTable {
		return mTable
	}

	public func fieldName(_ idx: JSValue) -> JSValue {
		if let i = valueToInt(value: idx) {
			if let fname = mTable.fieldName(at: i) {
				return JSValue(object: fname, in: mContext)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func fieldNames() -> JSValue {
		var array: Array<NSString> = []
		for name in mTable.fieldNames() {
			array.append(name as NSString)
		}
		return JSValue(object: array, in: mContext)
	}

	public func newRecord() -> JSValue {
		let recobj = mTable.newRecord()
		if let val = allocateRecord(record: recobj) {
			return val
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func record(_ row: JSValue) -> JSValue {
		if row.isNumber {
			let ridx = row.toInt32()
			if let rec = mTable.record(at: Int(ridx)) {
				if let val = allocateRecord(record: rec) {
					return val
				} else {
					CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
				}
			} else {
				CNLog(logLevel: .error, message: "Unexpected record type", atFunction: #function, inFile: #file)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func records() -> JSValue {
		var result: Array<JSValue> = []
		for rec in mTable.records() {
			let recobj = KLRecord(record: rec, context: mContext)
			if let recval = KLRecord.allocate(record: recobj) {
				result.append(recval)
			}
		}
		return JSValue(object: result, in: mContext)
	}

	public func select(_ name: JSValue, _ val: JSValue) -> JSValue {
                var result: Array<JSValue> = []
		if let name = valueToString(value: name) {
			let nval = valueToNative(value: val)
                        let recs = mTable.select(name: name, value: nval)
                        for rec in recs {
                                let recobj = KLRecord(record: rec, context: mContext)
                                if let recval = KLRecord.allocate(record: recobj) {
                                        result.append(recval)
                                }
                        }
		} else {
			CNLog(logLevel: .error, message: "Invalid paraeter type", atFunction: #function, inFile: #file)
		}
                return JSValue(object: result, in: mContext)
	}

	public var current: JSValue { get {
		if let rec = mTable.current {
			if let result = allocateRecord(record: rec) {
				return result
			}
		}
		return JSValue(nullIn: mContext)
	}}

	public func load(from val: JSValue) -> Bool {
		var result: Bool
		let converter = KLScriptValueToNativeValue()
		let nval = converter.convert(scriptValue: val)
		if let arr = nval.toArray() {
			if let err = mTable.load(value: arr, from: nil) {
				CNLog(logLevel: .error, message: err.toString())
				result = false
			} else {
				result = true // Success
			}
		} else {
			CNLog(logLevel: .error, message: "The table value must has array of record values")
			result = false
		}
		return result
	}

	public func append(_ rcd: JSValue) {
		if rcd.isObject {
			if let rec = rcd.toObject() as? KLRecord {
				mTable.append(record: rec.core())
			}
		}
	}

	public func remove(_ idxval: JSValue) -> JSValue {
		var result = false
		if idxval.isNumber {
			if let idxnum = idxval.toNumber() {
				let idx = idxnum.intValue
				result = mTable.remove(at: idx)
			}
		}
		return JSValue(bool: result, in: mContext)
	}

	//public func save() -> JSValue {
	//	return JSValue(bool: mTable.save(), in: mContext)
	//}

	public func forEach(_ callback: JSValue) {
		mTable.forEach(callback: {
			(_ rec: CNRecord) -> Void in
			if let vobj = allocateRecord(record: rec) {
				callback.call(withArguments: [vobj])
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
			}
		})
	}

	private func allocateRecord(record rec: CNRecord) -> JSValue? {
		let rec = KLRecord(record: rec, context: mContext)
		if let val = KLRecord.allocate(record: rec) {
			return val
		} else {
			return nil
		}
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
		if let num = val.toNumber() {
			return num.intValue
		} else {
			return nil
		}
	}
}

