/**
 * @file	KLBitmapValue.swift
 * @brief	Define KLBitmapValue class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

extension JSValue
{
	public var isBitmap: Bool { get {
		if let _ = self.toObject() as? KLBitmapData {
			return true
		} else {
			return false
		}
	}}

	public func toBitmap() -> KLBitmapData? {
		return self.toObject() as? KLBitmapData
	}
}

@objc public protocol KLBitmapDataProtocol: JSExport {
	var 	width:		JSValue { get }
	var	height:		JSValue { get }

	func get(_ xval: JSValue, _ yval: JSValue) -> JSValue
	func set(_ xval: JSValue, _ yval: JSValue, _ data: JSValue) -> JSValue
	func clean()
}

@objc public class KLBitmapData: NSObject, KLBitmapDataProtocol {
	private var 	mBitmap:	CNBitmapData
	private var	mContext:	KEContext

	public init(bitmap bm: CNBitmapData, context ctxt: KEContext) {
		mBitmap		= bm
		mContext	= ctxt
	}

	public var core:   CNBitmapData { get { return mBitmap }}
	public var width:  JSValue { get { return JSValue(int32: Int32(mBitmap.width),  in: mContext) }}
	public var height: JSValue { get { return JSValue(int32: Int32(mBitmap.height), in: mContext) }}

	public func get(_ xval: JSValue, _ yval: JSValue) -> JSValue {
		if xval.isNumber && yval.isNumber {
			let x = Int(xval.toInt32())
			let y = Int(yval.toInt32())
			if let col = mBitmap.get(x: x, y: y) {
				return col.toJSValue(context: mContext)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func set(_ xval: JSValue, _ yval: JSValue, _ data: JSValue) -> JSValue {
		guard xval.isNumber && yval.isNumber else {
			return JSValue(bool: false, in: mContext)
		}
		let result: Bool
		let x = Int(xval.toInt32())
		let y = Int(yval.toInt32())
		if let col = CNColor.fromJSValue(scriptValue: data) {
			mBitmap.set(x: x, y: y, color: col)
			result = true
		} else if let bm = data.toObject() as? KLBitmapData {
			mBitmap.set(x: x, y: y, bitmap: bm.core)
			result = true
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter: \(String(describing: data.toString()))", atFunction: #function, inFile: #file)
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func clean() {
		mBitmap.clean()
	}
}

