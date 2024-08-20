/**
 * @file	KLDate.swift
 * @brief	Define KLDate class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

@objc public protocol KLDateProtocol: JSExport
{
	func toString() -> JSValue
	var year:  JSValue { get }
	var month: JSValue { get }
	var day:   JSValue { get }
}

@objc public class KLDate: NSObject, KLDateProtocol
{
	private var mDate:	Date
	private var mContext:	KEContext

	public init(date dt: Date, context ctxt: KEContext){
		mDate 		= dt
		mContext	= ctxt
	}

	public func toString() -> JSValue {
		return JSValue(object: mDate.description, in: mContext)
	}

	public var year: JSValue { get {
		return JSValue(int32: Int32(mDate.year), in: mContext)
	}}

	public var month: JSValue { get {
		return JSValue(int32: Int32(mDate.month), in: mContext)
	}}

	public var day: JSValue { get {
		return JSValue(int32: Int32(mDate.day), in: mContext)
	}}
}


