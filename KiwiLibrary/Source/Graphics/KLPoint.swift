/**
 * @file	KLPoint.swift
 * @brief	Define KLPoint class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

public extension CGPoint
{
	static func isPoint(scriptValue val: JSValue) -> Bool {
		if let dict = val.toDictionary() {
			if let _ = dict["x"], let _ = dict["y"] {
				return true
			}
		}
		return false
	}

	static func fromJSValue(_ xval: JSValue, _ yval: JSValue) -> CGPoint? {
		if let xnum = xval.toNumber(), let ynum = yval.toNumber() {
			return CGPoint(x: xnum.doubleValue, y: ynum.doubleValue)
		} else {
			CNLog(logLevel: .error, message: "Number parameters are required for Point")
			return nil
		}
	}

	static func fromJSValue(scriptValue val: JSValue) -> CGPoint? {
		if let dict = val.toDictionary() {
			if let xnum = dict["x"] as? NSNumber, let ynum = dict["y"] as? NSNumber {
				return CGPoint(x: xnum.doubleValue, y: ynum.doubleValue)
			}
		}
		return nil
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		let x  = NSNumber(floatLiteral: self.x)
		let y = NSNumber(floatLiteral:  self.y)
		let dict: Dictionary<String, NSObject> = [
			"x": x,
			"y": y
		]
		return JSValue(object: dict, in: ctxt)
	}
}

