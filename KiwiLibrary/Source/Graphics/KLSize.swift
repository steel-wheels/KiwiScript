/**
 * @file	KLSize.swift
 * @brief	Define KLSize class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

public extension CGSize
{
	static func isSize(scriptValue val: JSValue) -> Bool {
		if let dict = val.toDictionary() {
			if let _ = dict["width"], let _ = dict["height"] {
				return true
			}
		}
		return false
	}

	static func fromJSValue(_ wval: JSValue, _ hval: JSValue) -> CGSize? {
		if let wnum = wval.toNumber(), let hnum = hval.toNumber() {
			return CGSize(width: wnum.doubleValue, height: hnum.doubleValue)
		} else {
			CNLog(logLevel: .error, message: "Number parameters are required for Size")
			return nil
		}
	}

	static func fromJSValue(scriptValue val: JSValue) -> CGSize? {
		if let ifval = val.toInterface(named: CGPoint.InterfaceName) {
			if let wval = ifval.get(name: "width"), let hval = ifval.get(name: "height") {
				if let wnum = wval.toNumber(), let hnum = hval.toNumber() {
					return CGSize(width: wnum.doubleValue, height: hnum.doubleValue)
				}
			}
		}
		return nil
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		let width  = NSNumber(floatLiteral: self.width)
		let height = NSNumber(floatLiteral: self.height)
		let dict: Dictionary<String, NSObject> = [
			"width":  width,
			"height": height
		]
		return JSValue(object: dict, in: ctxt)
	}
}

