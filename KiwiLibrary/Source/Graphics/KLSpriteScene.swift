/**
 * @file	KLSpritScenee.swift
 * @brief	Define KLSpriteScene class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import SpriteKit
import JavaScriptCore
import Foundation

@objc public protocol KLSpriteSceneProtocol: JSExport
{
	var currentTime:	JSValue { get }		// Double
	var trigger:		JSValue { get }		// ProcessStatus
	var field:		JSValue { get }		// KLSpriteField
	var size:		JSValue { get }

	func finish()
}

@objc public class KLSpriteScene: NSObject, KLSpriteSceneProtocol
{
	private var mScene:	CNSpriteScene
	private var mContext:	KEContext
	private var mDoFinish:	Bool

	public var doFinish: Bool { get {
		return mDoFinish
	}}

	public init(scene sc: CNSpriteScene, context ctxt: KEContext){
		mScene		= sc
		mContext	= ctxt
		mDoFinish	= false
	}

	public var currentTime: JSValue { get {
		return JSValue(double: mScene.currentTime, in: mContext)
	}}

	public var trigger: JSValue { get {
		let obj = KLTrigger(trigger: mScene.trigger, context: mContext)
		return JSValue(object: obj, in: mContext)
	}}

	public var field: JSValue { get {
		let fldobj = KLSpriteField(spriteField: mScene.field, context: mContext)
		return JSValue(object: fldobj, in: mContext)
	}}

	public var size: JSValue { get {
		return mScene.size.toJSValue(context: mContext)
	}}

	public func finish() {
		mDoFinish = true
	}
}


