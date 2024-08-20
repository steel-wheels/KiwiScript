/**
 * @file	KLMenuItem.swift
 * @brief	Define KLMenuItem class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation
#if os(OSX)
import AppKit
#else
import UIKit
#endif

@objc public protocol KLMenuItemProtocol: JSExport
{
        var title:      JSValue { get }         // string
        var value:      JSValue { get }         // number
}

public protocol KLMenuItemCoreProtocol
{
        func core() -> CNMenuItem
}

@objc open class KLMenuItem: NSObject, KLMenuItemProtocol, KLMenuItemCoreProtocol
{
        private var mItem:      CNMenuItem
        private var mContext:   KEContext

        public init(menuItem item: CNMenuItem, context ctxt: KEContext){
                mItem           = item
                mContext        = ctxt
        }

        public func core() -> CNMenuItem {
                return mItem
        }

        public var title: JSValue { get {
                return JSValue(object: mItem.title, in: mContext)
        }}

        public var value: JSValue { get {
                return JSValue(int32: Int32(mItem.value), in: mContext)
        }}
}
