/**
 * @file	KLColor.swift
 * @brief	Define KLColor class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
#if os(OSX)
import AppKit
#else
import UIKit
#endif

public extension CNColor
{
	static func isColor(scriptValue val: JSValue) -> Bool {
		return val.isInterface(named: CNColor.InterfaceName)
	}

	static func fromJSValue(scriptValue val: JSValue) -> CNColor? {
		if let ifval = val.toInterface(named: CNColor.InterfaceName) {
			if let rval = ifval.get(name: "r"), let gval = ifval.get(name: "g"),
			   let bval = ifval.get(name: "b"), let aval = ifval.get(name: "a")   {
				if let rnum = rval.toNumber(), let gnum = gval.toNumber(),
				   let bnum = bval.toNumber(), let anum = aval.toNumber() {
					let r = CGFloat(rnum.doubleValue)
					let g = CGFloat(gnum.doubleValue)
					let b = CGFloat(bnum.doubleValue)
					let a = CGFloat(anum.doubleValue)
					#if os(OSX)
					return CNColor(calibratedRed: r, green: g, blue: b, alpha: a)
					#else
					return CNColor(red: r, green: g, blue: b, alpha: a)
					#endif
				}
			}
		}
		return nil
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		return self.toValue().toJSValue(context: ctxt)
	}
}

@objc public protocol KLColorsProtocol: JSExport
{
	var black:	JSValue { get }
	var red:	JSValue { get }
	var green:	JSValue { get }
	var yellow:	JSValue { get }
	var blue:	JSValue { get }
	var magenta:	JSValue { get }
	var cyan:	JSValue { get }
	var white:	JSValue { get }
	var clear:	JSValue { get }
	var availableColorNames:	JSValue { get }
}

@objc public class KLColors: NSObject, KLColorsProtocol
{
	private var mContext: KEContext

	public init(context ctxt: KEContext) {
		mContext = ctxt
	}

	public var black: 	JSValue { get { return CNColor.black.toJSValue(context: mContext)	}}
	public var red:   	JSValue { get { return CNColor.red.toJSValue(context: mContext) 	}}
	public var green:	JSValue { get { return CNColor.green.toJSValue(context: mContext)	}}
	public var yellow:	JSValue { get { return CNColor.yellow.toJSValue(context: mContext)	}}
	public var blue:	JSValue { get { return CNColor.blue.toJSValue(context: mContext) 	}}
	public var magenta:	JSValue { get { return CNColor.magenta.toJSValue(context: mContext)	}}
	public var cyan:	JSValue { get { return CNColor.cyan.toJSValue(context: mContext) 	}}
	public var white:	JSValue { get { return CNColor.white.toJSValue(context: mContext)	}}
	public var clear:	JSValue { get { return CNColor.clear.toJSValue(context: mContext)	}}

	public var availableColorNames:	JSValue { get {
		let result = NSMutableArray()
		let names = CNColors.availableColorNames
		for name in names {
			result.add(name as NSString)
		}
		return JSValue(object: result, in: mContext)
	}}
}

