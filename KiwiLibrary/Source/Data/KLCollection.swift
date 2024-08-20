/**
 * @file	KLCollection.swift
 * @brief	Define KLCollection class
 * @par Copyright
 *   Copyright (C) 2021 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

@objc public protocol KLCollectionProtocol: JSExport
{
    var count: JSValue { get }

	func item(_ idx: JSValue) -> JSValue

	func addItems(_ items: JSValue)
    func addItem(_ item: JSValue)
}

@objc public protocol KLIconProtocol: JSExport
{
    var tag:    JSValue { get }         // tag: numner
    var symbol: JSValue { get }         // symbol: SymbolIF
    var title:  JSValue { get }         // title: String
}

@objc public class KLIcon: NSObject, KLIconProtocol
{
    private var mCore:      CNIcon
    private var mContext:   KEContext

    public init(core obj: CNIcon, context ctxt: KEContext) {
        mCore       = obj
        mContext    = ctxt
    }

    public var core: CNIcon { get {
        return mCore
    }}

    public var tag: JSValue { get {
        let num = NSNumber(integerLiteral: mCore.tag)
        return JSValue(object: num, in: mContext)
    }}

    public var symbol: JSValue { get {
        return JSValue(object: mCore.symbol.name, in: mContext)
    }}

    public var title: JSValue { get {
        return JSValue(object: mCore.title, in: mContext)
    }}

    public static func encode(tag tagval: JSValue, symbol symval: JSValue, title ttlval: JSValue, context ctxt: KEContext) -> CNIcon? {
        guard let tagnum = tagval.toNumber() else {
            return nil
        }
        guard let symstr = symval.toString() else {
            return nil
        }
        guard let ttlstr = ttlval.toString() else {
            return nil
        }
        guard let symbol = CNSymbol.decode(fromName: symstr) else {
            return nil
        }
        return CNIcon(tag: tagnum.intValue, symbol: symbol, title: ttlstr)
    }
}


@objc public class KLCollection: NSObject, KLCollectionProtocol
{
	private var mCollection:	CNCollectionData
	private var mContext:		KEContext

	public var core: CNCollectionData { get { return mCollection }}

	public init(collection col: CNCollectionData, context ctxt: KEContext){
		mCollection	= col
		mContext	= ctxt
	}

	public var count: JSValue { get {
		return JSValue(int32: Int32(mCollection.count), in: mContext)
	}}

	public func item(_ idxval: JSValue) -> JSValue {
        guard let idxnum = idxval.toNumber() else {
            CNLog(logLevel: .error, message: "The index parameter must have number")
            return JSValue(nullIn: mContext)
        }
        let idx = idxnum.intValue
        if let icon = mCollection.icon(at: idx) {
            let obj = KLIcon(core: icon, context: mContext)
            return JSValue(object: obj, in: mContext)
        } else {
            return JSValue(nullIn: mContext)
        }
	}

	public func addItem(_ item: JSValue){
        if let obj = item.toObject() {
            addObject(object: obj)
        } else {
            CNLog(logLevel: .error, message: "Unexpected object type", atFunction: #function, inFile: #file)
        }
	}

    public func addItems(_ items: JSValue){
        if let arr = items.toArray() {
            for elm in arr {
                    addObject(object: elm)
            }
        } else {
            CNLog(logLevel: .error, message: "Array of items are required", atFunction: #function, inFile: #file)
        }
    }

    private func addObject(object aobj: Any) {
        if let obj = aobj as? KLIcon {
            mCollection.add(icon: obj.core)
        } else {
            CNLog(logLevel: .error, message: "Unexpected object type", atFunction: #function, inFile: #file)
        }
    }
}


