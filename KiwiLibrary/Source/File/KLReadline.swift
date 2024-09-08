/**
 * @file        KLReadline.swift
 * @brief        Define KLReadline class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLReadlineProtocol: JSExport
{
        func execute() -> JSValue
}

@objc public class KLReadline: NSObject, KLReadlineProtocol
{
        private var mReadline:  CNReadline
        private var mConsole:   CNFileConsole
        private var mType:      CNApplicationType
        private var mContext:   KEContext

        public init(console cons: CNFileConsole, applicationType atype: CNApplicationType, context ctxt: KEContext) {
                mReadline = CNReadline()
                mConsole  = cons
                mType     = atype
                mContext  = ctxt
        }

        public func execute() -> JSValue {
                let result: String?
                switch mReadline.execute(console: mConsole, applicationType: mType) {
                case .doExecute(let str):
                        result = str
                case .doContinue, .doExit:
                        result = nil
                @unknown default:
                        NSLog("[Error] internal error")
                        result = nil
                }
                if let str = result {
                        return JSValue(object: str, in: mContext)
                } else {
                        return JSValue(nullIn: mContext)
                }
        }
}

