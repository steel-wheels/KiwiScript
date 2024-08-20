/**
 * @file	KLURL.swift
 * @brief	Define KLURL class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLURLProtocol: JSExport
{
	var isNull: JSValue { get }
	var absoluteString: JSValue { get }
	var path: JSValue { get }
	var lastPathComponent: JSValue { get }		// -> String
	var deletingLastPathComponent: JSValue { get }	// -> URL

	func appending(_ compval: JSValue) -> JSValue	// -> URL

	func loadText() -> JSValue
}

@objc public class KLURL: NSObject, KLURLProtocol, KLEmbeddedObject
{
	private var mURL:	URL
	private var mContext:	KEContext

	public init(URL u: URL, context ctxt: KEContext){
		mURL	 	= u
		mContext 	= ctxt
	}

	public func copy(context ctxt: KEContext) -> KLEmbeddedObject {
		return KLURL(URL: self.mURL, context: ctxt)
	}

	public var url: URL? { get { return mURL }}

	public var isNull: JSValue { get {
		return JSValue(bool: mURL.isNull, in: mContext)
	}}

	public var absoluteString: JSValue { get {
		return JSValue(object: mURL.absoluteString, in: mContext)
	}}

	public var path: JSValue { get {
		return JSValue(object: mURL.path, in: mContext)
	}}

	public var lastPathComponent: JSValue { get {
		let str = mURL.lastPathComponent
		return JSValue(object: str, in: mContext)
	}}

	public var deletingLastPathComponent: JSValue { get {
		let url = mURL.deletingLastPathComponent()
		return JSValue(object: KLURL(URL: url, context: mContext), in: mContext)
	}}

	public func appending(_ val: JSValue) -> JSValue {
		if val.isString {
			if let str = val.toString() {
				let newurl = mURL.appending(path: str)
				return JSValue(object: KLURL(URL: newurl, context: mContext), in: mContext)
			} else {
				CNLog(logLevel: .error, message: "String parameter is required", atFunction: #function, inFile: #file)
				return JSValue(object: KLURL(URL: mURL, context: mContext), in: mContext)
			}
		} else if val.isURL {
			if let url = val.toURL() {
				let newurl = mURL.appending(path: url.path)
				return JSValue(object: KLURL(URL: newurl, context: mContext), in: mContext)
			} else {
				CNLog(logLevel: .error, message: "URL parameter is required", atFunction: #function, inFile: #file)
				return JSValue(object: KLURL(URL: mURL, context: mContext), in: mContext)
			}
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(object: KLURL(URL: mURL, context: mContext), in: mContext)
		}
	}

	public func loadText() -> JSValue {
		if let text = mURL.loadContents() {
			return JSValue(object: text, in: mContext)
		} else {
			CNLog(logLevel: .error, message: "Failed to load text at \(mURL.absoluteString)", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}
}

