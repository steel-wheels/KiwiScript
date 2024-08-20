/**
 * @file	KLSpriteField..swift
 * @brief	Define KLSpriteField class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import SpriteKit
import JavaScriptCore
import Foundation

@objc public protocol KLSpriteNodeRefProtocol: JSExport
{
	var material:   JSValue { get }		// CNSpriteMaterial
	var nodeId:     JSValue { get }		// number
	var position:	JSValue { get }		// CGPoint
}

@objc public protocol KLSpriteFieldProtocol: JSExport
{
	var size: JSValue { get }		// CGSize
	var nodes: JSValue { get }
}

@objc public class KLSpriteNodeRef: NSObject, KLSpriteNodeRefProtocol
{
	private var mNodeRef:	CNSpriteNodeRef
	private var mContext:	KEContext

	public init(nodeRef nref: CNSpriteNodeRef, context ctxt: KEContext) {
		self.mNodeRef = nref
		self.mContext = ctxt
	}

	public var material: JSValue { get {
		return JSValue(int32: Int32(mNodeRef.material.rawValue), in: mContext)
	}}

	public var nodeId: JSValue { get {
		return JSValue(int32: Int32(mNodeRef.nodeId), in: mContext)
	}}

	public var position: JSValue { get {
		return mNodeRef.position.toJSValue(context: mContext)
	}}
}

@objc public class KLSpriteField: NSObject, KLSpriteFieldProtocol
{
	private var mField:	CNSpriteField
	private var mContext:	KEContext

	public init(spriteField field: CNSpriteField, context ctxt: KEContext){
		mField		= field
		mContext	= ctxt
	}

	public var size: JSValue { get {
		return mField.size.toJSValue(context: mContext)
	}}

	public var nodes: JSValue { get {
		var result: Array<KLSpriteNodeRef> = []
		for node in mField.nodes {
			let obj = KLSpriteNodeRef(nodeRef: node, context: mContext)
			result.append(obj)
		}
		return JSValue(object: result, in: mContext)
	}}
}

