/**
 * @file	KLSpriteNode..swift
 * @brief	Define KLSpriteNode class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import SpriteKit
import JavaScriptCore
import Foundation

@objc public protocol KLSpriteNodeProtocol: JSExport
{
	var nodeId:	JSValue { get }		// integer
	var material:	JSValue { get }		// CNSpriteMaterial
	var trigger:	JSValue { get }		// ProcessStatus
	var position:	JSValue { get }		// PointIF
	var size:	JSValue { get }		// SizeIF
	var velocity:	JSValue { get }		// VectorIF
	var mass:	JSValue { get }		// double
	var density:	JSValue { get }		// double
	var area:	JSValue { get }		// double

	var actions:	JSValue { get }		// SpriteActions
}

public extension SKNode
{
	//static let ContextItem: String = "context"

	func setupNode(virtualMachine vm: JSVirtualMachine,  material mat: CNSpriteMaterial, machine mcn: String, nodeId nid: Int) {
		self.setupNode( material: mat, machine: mcn, nodeId: nid)
		let ctxt = KEContext(virtualMachine: vm)
		self.scriptContext = ctxt
	}

	var context: KEContext? {
		get {
			if let ctxt = self.scriptContext as? KEContext {
				return ctxt
			} else {
				CNLog(logLevel: .error, message: "No context", atFunction: #function, inFile: #file)
				return nil
			}
		}
		set(ctxtp){
			self.scriptContext = ctxtp
		}
	}

	func loadScript(scriptFile scrfile: URL, resource res: KEResource, environment env: CNEnvironment, console cons: CNFileConsole) -> Bool {
		guard let ctxt = self.context else {
			cons.print(string: "[Error] No context\n")
			return false
		}

		/* Prepare the context */
		let config   = KEConfig(applicationType: .terminal, doStrict: true, logLevel: .defaultLevel)
		let compiler = KLLibraryCompiler()
		if !compiler.compile(context: ctxt, resource: res, console: cons, environment: env, config: config) {
			cons.print(string: "[Error] Failed to compile the context for sprite node\n")
			return false
		}

		/* Compile the script */
		var result = true
		if let scr = scrfile.loadContents() as? String {
			ctxt.evaluateScript(scr, withSourceURL: scrfile)
			if ctxt.errorCount != 0 {
				cons.print(string: "[Error] Failed to compile script at: \"\(scrfile.path)\"\n")
				ctxt.resetErrorCount()
				result = false
			}
		} else {
			cons.print(string: "[Error] Failed to load thread script from \"\(scrfile.path)\"\n")
			result = false
		}
		return result
	}
}

@objc public class KLSpriteNode: NSObject, KLSpriteNodeProtocol
{
	private var mNode:	SKNode
	private var mContext:	KEContext

	public init(node nd: SKNode, context ctxt: KEContext){
		mNode		= nd
		mContext	= ctxt
	}

	public var nodeId:	JSValue { get {
		return JSValue(int32: Int32(mNode.nodeId), in: mContext)
	}}

	public var material:	JSValue { get {
		return JSValue(int32: Int32(mNode.material.rawValue), in: mContext)
	}}

	public var trigger: JSValue { get {
		let trgobj = KLTrigger(trigger: mNode.trigger, context: mContext)
		return JSValue(object: trgobj, in: mContext)
	}}

	public var size: JSValue { get {
		let size = mNode.frame.size
		return size.toJSValue(context: mContext)
	}}

	public var position: JSValue { get {
		return mNode.position.toJSValue(context: mContext)
	}}

	public var velocity: JSValue { get {
		let vel: CGVector
		if let body = mNode.physicsBody {
			vel = body.velocity
		} else {
			CNLog(logLevel: .error, message: "No physics body", atFunction: #function, inFile: #file)
			vel = CGVector(dx: 0.0, dy: 0.0)
		}
		return vel.toJSValue(context: mContext)
	}}

	public var mass: JSValue { get {
		return JSValue(double: mNode.mass, in: mContext)
	}}

	public var density: JSValue { get {
		return JSValue(double: mNode.density, in: mContext)
	}}

	public var area: JSValue { get {
		return JSValue(double: mNode.area, in: mContext)
	}}

	public var actions: JSValue { get {
		return JSValue(object: KLSpriteActions(actions: mNode.actions), in: mContext)
	}}
}

