/**
 * @file	KLSpriteAction..swift
 * @brief	Define KLSpriteAction class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import SpriteKit
import JavaScriptCore
import Foundation

@objc public protocol KLSpriteActionsProtocol: JSExport
{
	func clear()
	func setPosition(_ pos: JSValue)	// CGPoint
	func setVelocity(_ vec: JSValue)	// CGVector
	func retire()
}

@objc public class KLSpriteActions: NSObject, KLSpriteActionsProtocol
{
	private var mActions: CNSpriteActions

	public var core: CNSpriteActions { get { return mActions }}

	public init(actions acts: CNSpriteActions) {
		self.mActions = acts
	}

	public func clear() {
		mActions.clear()
	}

	public func setPosition(_ pos: JSValue) {
		if pos.isPoint {
			if let val = CGPoint.fromJSValue(scriptValue: pos) {
				mActions.setPosition(val)
				return
			}
		}
		CNLog(logLevel: .error, message: "Invalid parameter type", atFunction: #function, inFile: #file)
	}

	public func setVelocity(_ vec: JSValue) {
		if vec.isVector {
			if let val = CGVector.fromJSValue(scriptValue: vec) {
				mActions.setVelocity(val)
				return
			}
		}
		CNLog(logLevel: .error, message: "Invalid parameter type", atFunction: #function, inFile: #file)
	}

	public func retire() {
		mActions.retire()
	}
}



