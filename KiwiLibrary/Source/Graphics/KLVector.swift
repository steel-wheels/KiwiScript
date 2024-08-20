/**
 * @file	KLVector..swift
 * @brief	Define KLVector class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

public extension CGVector
{
	static func isVector(scriptValue val: JSValue) -> Bool {
		if let dict = val.toDictionary() {
			if let _ = dict["dx"] as? NSNumber, let _ = dict["dy"] as? NSNumber {
				return true
			}
		}
		return false
	}

	static func fromJSValue(_ dxval: JSValue, _ dyval: JSValue) -> CGVector? {
		if dxval.isNumber && dyval.isNumber {
			if let dxnum = dxval.toNumber(), let dynum = dyval.toNumber() {
				return CGVector(dx: dxnum.doubleValue, dy: dynum.doubleValue)
			}
		}
		CNLog(logLevel: .error, message: "Number parameters are required for Vector")
		return nil
	}

	static func fromJSValue(scriptValue val: JSValue) -> CGVector? {
		if let dict = val.toDictionary() {
			if let dx = dict["dx"] as? NSNumber, let dy = dict["dy"] as? NSNumber {
				return CGVector(dx: dx.doubleValue, dy: dy.doubleValue)
			}
		}
		return nil
	}

	func toJSValue(context ctxt: KEContext) -> JSValue {
		let dx = NSNumber(floatLiteral: self.dx)
		let dy = NSNumber(floatLiteral: self.dy)
		let dict: Dictionary<String, NSObject> = [
			"dx": dx,
			"dy": dy
		]
		return JSValue(object: dict, in: ctxt)
	}
}
