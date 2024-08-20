/**
 * @file	KLTrigger.swift
 * @brief	Define KLTrigger class
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLTriggerProtocol: JSExport
{
	func trigger()
	func isRunning() -> JSValue 	// -> Bool
	func ack()
}

@objc public class KLTrigger: NSObject, KLTriggerProtocol
{
	private var mTrigger: CNTrigger
	private var mContext: KEContext

	public init(trigger trg: CNTrigger, context ctxt: KEContext){
		mTrigger	= trg
		mContext	= ctxt
	}

	public func trigger() {
		mTrigger.trigger()
	}

	public func isRunning() -> JSValue {
		return JSValue(bool: mTrigger.isRunning(), in: mContext)
	}

	public func ack() {
		mTrigger.ack()
	}
}

