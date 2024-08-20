/**
 * @file	KLOval.swift
 * @brief	Define KLOval class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

public extension CNOval
{
	static func isOval(scriptValue val: JSValue) -> Bool {
		if let dict = val.toDictionary() {
			if let _ = dict["x"], let _ = dict["y"], let _ = dict["radius"] {
				return true
			}
		}
		return false
	}

	static func fromJSValue(_ xval: JSValue, _ yval: JSValue, _ radval: JSValue) -> CNOval? {
		if let xnum = xval.toNumber(), let ynum = yval.toNumber(), let radnum = radval.toNumber() {
			return CNOval(center: CGPoint(x: xnum.doubleValue, y: ynum.doubleValue), radius: radnum.doubleValue)
		} else {
			CNLog(logLevel: .error, message: "Number parameters are required for Oval")
			return nil
		}
	}

	static func fromJSValue(scriptValue val: JSValue) -> CNOval? {
		guard let dict = val.toDictionary() else {
			CNLog(logLevel: .error, message: "The oval value must be dictionary")
			return nil
		}
		guard let xnum = dict["x"] as? NSNumber, let ynum = dict["y"] as? NSNumber, let rnum = dict["radius"] as? NSNumber else {
			CNLog(logLevel: .error, message: "Number parameter is required for Oval")
			return nil
		}
		return CNOval(center: CGPoint(x: xnum.doubleValue, y: ynum.doubleValue), radius: rnum.doubleValue)
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		let x = NSNumber(floatLiteral: self.center.x)
		let y = NSNumber(floatLiteral: self.center.y)
		let r = NSNumber(floatLiteral: self.radius)
		let dict: Dictionary<String, NSObject> = [
			"x": 		x,
			"y": 		y,
			"radius":	r
		]
		return JSValue(object: dict, in: ctxt)
	}
}

