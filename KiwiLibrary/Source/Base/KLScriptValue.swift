/**
 * @file	KLScriptValue.swift
 * @brief	Extend JSValue class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension JSValue
{
	public convenience init(URL url: URL, in context: KEContext) {
		let urlobj = KLURL(URL: url, context: context)
		self.init(object: urlobj, in: context)
	}

	public convenience init(image img: CNImage, in context: KEContext) {
		let imgobj = KLImage(context: context)
		imgobj.coreImage = img
		self.init(object: imgobj, in: context)
	}

	public static func hasClassName(value val: JSValue, className name: String) -> Bool {
		if let dict = val.toObject() as? Dictionary<String, Any> {
			if let str = dict["class"] as? String {
				return str == name
			}
		}
		return false
	}

	public var isDictionary: Bool {
		get {
			if let _ = self.toDictionary()	{
				return true
			} else {
				return false
			}
		}
	}

	public var isSet: Bool { get {
		return CNValueSet.isSet(scriptValue: self)
	}}

	public func toSet() -> CNValue? {
		return CNValueSet.fromJSValue(scriptValue: self)
	}

	public var isPoint: Bool {
		get { return CGPoint.isPoint(scriptValue: self) }
	}

	public var isSize: Bool {
		get { return CGSize.isSize(scriptValue: self) }
	}

	public var isRect: Bool {
		get { return CGRect.isRect(scriptValue: self) }
	}

	public var isOval: Bool {
		get { return CNOval.isOval(scriptValue: self) }
	}

	public var isVector: Bool {
		get { return CGVector.isVector(scriptValue: self) }
	}

	public var isRange: Bool {
		get { return NSRange.isRange(scriptValue: self) }
	}

	public func toRange() -> NSRange? {
		if let ifval = self.toInterface(named: NSRange.InterfaceName) {
			return NSRange.fromValue(value: ifval)
		} else {
			return nil
		}
	}

	public var isEnum: Bool {
		get { return CNEnum.isEnum(scriptValue: self) }
	}

	public func toEnum() -> CNEnum? {
		return CNEnum.fromJSValue(scriptValue: self)
	}

	public func isInterface(named name: String) -> Bool {
		if let ifval = self.toObject() as? KLInterfaceValue {
			let iftype = ifval.core.type
			if iftype.name == name {
				return true
			}
		}
		return false
	}

	public func toInterface(named name: String) -> CNInterfaceValue? {
		if let ifval = self.toObject() as? KLInterfaceValue {
			return ifval.core
		} else {
			return nil
		}
	}

	public var isURL: Bool {
		get {
			if let urlobj = self.toObject() as? KLURL {
				if let _ = urlobj.url {
					return true
				}
			}
			return false
		}
	}

	public func toURL() -> URL? {
		if let urlobj = self.toObject() as? KLURL {
			if let url = urlobj.url {
				return url
			}
		}
		return nil
	}

	public var isImage: Bool { get {
		if let imgobj = self.toObject() as? KLImage {
			if let _ = imgobj.coreImage {
				return true
			}
		}
		return false
	}}

	public func toImage() -> CNImage? {
		if let imgobj = self.toObject() as? KLImage {
			if let img = imgobj.coreImage {
				return img
			}
		}
		return nil
	}

	public var isRecord: Bool { get {
		if let _ = self.toObject() as? KLRecord {
			return true
		} else {
			return false
		}
	}}

	public func toRecord() -> CNRecord? {
		if let recobj = self.toObject() as? KLRecordCoreProtocol {
			return recobj.core()
		} else {
			return nil
		}
	}

	public var isColor: Bool { get {
		return CNColor.isColor(scriptValue: self)
	}}

	public func toColor() -> CNColor? {
		return CNColor.fromJSValue(scriptValue: self)
	}

	private func anyToDouble(any aval: Any?) -> CGFloat? {
		if let val = aval as? CGFloat {
			return val
		} else if let val = aval as? Double {
			return CGFloat(val)
		} else if let val = aval as? NSNumber {
			return CGFloat(val.floatValue)
		} else {
			return nil
		}
	}

	private func anyToInt(any aval: Any?) -> Int? {
		if let val = aval as? Int {
			return val
		} else if let val = aval as? NSNumber {
			return val.intValue
		} else {
			return nil
		}
	}

	private func anyToString(any aval: Any?) -> String? {
		if let val = aval as? String {
			return val
		} else {
			return nil
		}
	}

	public var type: CNValueType? { get {
		var result: CNValueType?
		if self.isUndefined {
			result = nil
		} else if self.isNull {
			result = .objectType(nil)
		} else if self.isBoolean {
			result = .boolType
		} else if self.isNumber {
			result = .numberType
		} else if self.isString {
			result = .stringType
		} else if self.isArray {
			result = .arrayType(.anyType)
		} else if self.isSet {
			result = .setType(.anyType)
		} else if let ifname = CNInterfaceValue.interfaceName(scriptValue: self) {
			let vmgr = CNValueTypeManager.shared
			if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
				result = .interfaceType(iftype)
			} else {
				CNLog(logLevel: .error, message: "Unknown interface name: \(ifname)",
				      atFunction: #function, inFile: #file)
				result = .dictionaryType(.anyType)
			}
		} else if self.isDictionary {
			result = .dictionaryType(.anyType)
		} else if self.isObject {
			if let _ = self.toObject() as? Dictionary<AnyHashable, Any> {
				result = .dictionaryType(.anyType)
			} else {
				result = .objectType(nil)
			}
		} else {
			fatalError("Unknown type: \"\(self.description)\"")
		}
		return result
	}}

	public func toScript() -> CNText {
		let converter = KLScriptValueToNativeValue()
		let native    = converter.convert(scriptValue: self)
		return native.toScript()
	}
}

public class KLScriptValueToNativeValue
{
	public init() {
	}

	public func convert(scriptValue src: JSValue) -> CNValue {
		if let type = src.type {
			return convert(scriptValue: src, typed: type)
		} else {
			return .null
		}
	}

	private func convert(scriptValue src: JSValue, typed type: CNValueType) -> CNValue {
		let result: CNValue
		switch type {
		case .anyType, .voidType, .functionType(_, _):
			CNLog(logLevel: .error, message: "Can not assign native value", atFunction: #function, inFile: #file)
			result = CNValue.null
		case .boolType:
			result = .boolValue(src.toBool())
		case .numberType:
			result = .numberValue(src.toNumber())
		case .stringType:
			result = .stringValue(src.toString())
		case .enumType:
			result = convert(enumValue: src.toEnum())
		case .arrayType:
			result = convert(arrayValue: src.toArray())
		case .setType:
			result = convert(setValue: src)
		case .dictionaryType:
			result = convert(dictionaryValue: src.toDictionary())
		case .interfaceType(let iftype):
			if let dict = src.toDictionary() as? Dictionary<String, Any> {
				switch CNInterfaceValue.fromJSValue(interfaceType: iftype, values: dict) {
				case .success(let ifval):
					result = .interfaceValue(ifval)
				case .failure(let err):
					CNLog(logLevel: .error, message: "[Error] \(err.toString())",
					      atFunction: #function, inFile: #file)
					result = CNValue.null
				}
			} else {
				CNLog(logLevel: .error, message: "Failed to convert to Interface",
				      atFunction: #function, inFile: #file)
				result = CNValue.null
			}
		case .objectType:
			if let obj = src.toObject() {
				result = .objectValue(obj as AnyObject)
			} else {
				CNLog(logLevel: .error, message: "Failed to convert to Object", atFunction: #function, inFile: #file)
				result = CNValue.null
			}
		case .nullable(let coretype):
			if src.isNull {
				return .null
			} else {
				return convert(scriptValue: src, typed: coretype)
			}
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			result = CNValue.null
		}
		return result
	}

	public func convert(arrayValue src: Array<Any>) -> CNValue {
		var result: Array<CNValue> = []
		let converter = CNAnyObjecToValue()
		for elm in src {
			let nval = converter.convert(anyObject: elm as AnyObject)
			result.append(nval)
		}
		return .arrayValue(result)
	}

	public func convert(dictionaryValue src: Dictionary<AnyHashable, Any>) -> CNValue {
		let converter = CNAnyObjecToValue()
		var newdict: Dictionary<String, CNValue> = [:]
		for (hash, val) in src {
			if let key = hash as? String  {
				newdict[key] = converter.convert(anyObject: val as AnyObject)
			} else {
				CNLog(logLevel: .error, message: "Unexpected dictionary item: key=\(hash), value=\(val)", atFunction: #function, inFile: #file)
			}
		}
		let result: CNValue
		if let scalar = CNDictionaryToValue(dictionary: newdict) {
			result = scalar
		} else {
			result = .dictionaryValue(newdict)
		}
		return result
	}

	public func convert(setValue src: JSValue) -> CNValue {
		let result: CNValue
		if let val = CNValueSet.fromJSValue(scriptValue: src) {
			result = val
		} else {
			CNLog(logLevel: .error, message: "Failed to convert to set", atFunction: #function, inFile: #file)
			result = CNValue.null
		}
		return result
	}

	public func convert(enumValue src: CNEnum?) -> CNValue {
		let result: CNValue
		if let eval = src {
			result = CNValue.enumValue(eval)
		} else {
			result = CNValue.null
		}
		return result
	}
}
