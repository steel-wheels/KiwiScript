/**
 * @file	KLPipe.swift
 * @brief	Define KLPipe class
 * @par Copyright
 *   Copyright (C) 2017, 2018 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLPipeProtocol: JSExport
{
	var fileForReading: JSValue { get }
	var fileForWriting: JSValue { get }
}

@objc public class KLPipe: NSObject, KLPipeProtocol
{
	private var mPipe:	Pipe
	private var mContext:	KEContext

	public init(context ctxt: KEContext){
		mPipe    = Pipe()
		mContext = ctxt
	}

	public var core: Pipe { get { return mPipe }}

	public var fileForReading: JSValue { get {
		let file = KLFile(file: mPipe.fileForReading(fileType: .file), context: mContext)
		return JSValue(object: file, in: mContext)
	}}

	public var fileForWriting: JSValue { get {
		let file = KLFile(file: mPipe.fileForWriting(fileType: .file), context: mContext)
		return JSValue(object: file, in: mContext)
	}}
}

