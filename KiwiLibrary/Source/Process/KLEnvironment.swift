/**
 * @file	KLEnvironment .swift
 * @brief	Define KLEnvironment class
 * @par Copyright
 *   Copyright (C) 2019-2014  Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation


@objc public protocol KLEnvironmentProtocol: JSExport
{
	func setVariable(_ name: JSValue, _ val: JSValue)
	func getVariable(_ name: JSValue) -> JSValue
	func getAll() -> JSValue

	var currentDirectory: JSValue { get }
	var packageDirectory: JSValue { get }
    
    func searchPackage(_ name: JSValue) ->JSValue
}

@objc public class KLEnvironment: NSObject, KLEnvironmentProtocol
{
    private var mEnvironment:	CNEnvironment
    private var mContext:		KEContext
    
    public init(environment env: CNEnvironment, context ctxt: KEContext){
        mEnvironment	= env
        mContext	= ctxt
    }
    
    public func setVariable(_ name: JSValue, _ val: JSValue){
        if let nmstr = valueToString(value: name), let valstr = valueToString(value: val) {
            mEnvironment.setVariable(nmstr, valstr)
        } else {
            CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
        }
    }
    
    public func getVariable(_ name: JSValue) -> JSValue {
        if let nmstr = valueToString(value: name) {
            if let valstr = mEnvironment.getVariable(nmstr) {
                return JSValue(object: valstr, in: mContext)
            }
        } else {
            CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
        }
        return JSValue(nullIn: mContext)
    }
    
    public func getAll() -> JSValue {
        return JSValue(object: mEnvironment.getAll(), in: mContext)
    }
    
    public var currentDirectory: JSValue { get {
        let url = mEnvironment.currentDirectory
        let obj = KLURL(URL: url, context: mContext)
        return JSValue(object: obj, in: mContext)
    }}
    
    public var packageDirectory: JSValue { get {
        let url = mEnvironment.packageDirectory ?? URL.null()
        let obj = KLURL(URL: url, context: mContext)
        return JSValue(object: obj, in: mContext)
    }}
    
    public func searchPackage(_ nameval: JSValue) ->JSValue {
        if let name = valueToString(value: nameval) {
            if let url = mEnvironment.searchPackagePath(packageName: name) {
                let urlobj = KLURL(URL: url, context: mContext)
                return JSValue(object: urlobj, in: mContext)
            }
        }
        return JSValue(nullIn: mContext)
    }

	private func valueToString(value val: JSValue) -> String? {
		if val.isString {
			if let str = val.toString() {
				return str
			}
		}
		return nil
	}
}
