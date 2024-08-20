/**
 * @file	KLRect.swift
 * @brief	Define KLRect class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

public extension CGRect
{
	static func isRect(scriptValue val: JSValue) -> Bool {
		if let dict = val.toDictionary() {
			if let _ = dict["x"], let _ = dict["y"], let _ = dict["width"], let _ = dict["height"] {
				return true
			}
		}
		return false
	}

	static func fromJSValue(_ xval: JSValue, _ yval: JSValue, _ wval: JSValue, _ hval: JSValue) -> CGRect? {
		if let xnum = xval.toNumber(), let ynum = yval.toNumber(), let wnum = wval.toNumber(), let hnum = hval.toNumber() {
			return CGRect(x: xnum.doubleValue, y: ynum.doubleValue, width: wnum.doubleValue, height: hnum.doubleValue)
		} else {
			CNLog(logLevel: .error, message: "Number parameters are required for Rect")
			return nil
		}
	}

	static func fromJSValue(scriptValue val: JSValue) -> CGRect? {
		if let dict = val.toDictionary() {
			if let xval = dict["x"], let yval = dict["y"], let wval = dict["width"], let hval = dict["height"] {
				if let xnum = xval as? NSNumber,
				   let ynum = yval as? NSNumber,
				   let wnum = wval as? NSNumber,
				   let hnum = hval as? NSNumber {
					return CGRect(x: xnum.doubleValue, y: ynum.doubleValue, width: wnum.doubleValue, height: hnum.doubleValue)
				}
			}
		}
		return nil
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		let x = NSNumber(floatLiteral: self.origin.x)
		let y = NSNumber(floatLiteral: self.origin.y)
		let w = NSNumber(floatLiteral: self.width)
		let h = NSNumber(floatLiteral: self.height)
		let dict: Dictionary<String, NSObject> = [
			"x":      x,
			"y":      y,
			"width":  w,
			"height": h
		]
		return JSValue(object: dict, in: ctxt)
	}
}

