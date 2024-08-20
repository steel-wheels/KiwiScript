/**
 * @file	KLBitmapContext.swift
 * @brief	Define KLBitmapContext class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLBitmapContextProtocol: JSExport
{
	var width:      JSValue { get }
	var height:     JSValue { get }

	var data: 	JSExport { get }

	func set(_ xval: JSValue, _ yval: JSValue, _ colval: JSValue)
	func get(_ xval: JSValue, _ yval: JSValue) -> JSValue
	func clean()
}

@objc public class KLBitmapContext: NSObject, KLBitmapContextProtocol
{
	private var mBContext:	CNBitmapContext
	private var mJContext:	KEContext
	private var mConsole:	CNConsole

	public init(bitmapContext bctxt: CNBitmapContext, scriptContext sctxt: KEContext, console cons: CNConsole) {
		mBContext	= bctxt
		mJContext	= sctxt
		mConsole 	= cons
		super.init()
	}

	public var width:      JSValue { get { return JSValue(int32: Int32(mBContext.width),  in: mJContext) }}
	public var height:     JSValue { get { return JSValue(int32: Int32(mBContext.height), in: mJContext) }}

	public var data: JSExport {
		get {
			return KLBitmapData(bitmap: mBContext.data, context: mJContext)
		}
	}

	public func set(_ xval: JSValue, _ yval: JSValue, _ colval: JSValue) {
		if xval.isNumber && yval.isNumber && colval.isObject {
			let x = Int(xval.toInt32())
			let y = Int(yval.toInt32())
			if let col = CNColor.fromJSValue(scriptValue: colval) {
				mBContext.set(x: x, y: y, color: col)
			} else if let bm = colval.toObject() as? KLBitmapData {
				mBContext.set(x: x, y: y, bitmap: bm.core)
			} else {
				mConsole.error(string: "[Error] Invalid color parameter: \(String(describing: colval.toString()))\n")
			}
		} else {
			mConsole.error(string: "[Error] Invalid parameter at \(#file)\n")
		}
	}

	public func clean() {
		mBContext.clean()
	}

	public func get(_ xval: JSValue, _ yval: JSValue) -> JSValue {
		if xval.isNumber && yval.isNumber {
			let x = Int(xval.toInt32())
			let y = Int(yval.toInt32())
			if let col = mBContext.get(x: x, y: y) {
				return col.toJSValue(context: mJContext)
			}
		}
		return JSValue(nullIn: mJContext)
	}
}


