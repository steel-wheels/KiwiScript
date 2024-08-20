/**
 * @file	KLFileManager.swift
 * @brief	Define KLFileManager class
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation


@objc public protocol KLFileManagerProtocol: JSExport
{
	func open(_ pathurl: JSValue, _ acctype: JSValue) -> JSValue
	func copy(_ fromfile: JSValue, _ tofile: JSValue) -> JSValue
	func remove(_ file: JSValue) -> JSValue

	func fileExists(_ pathstr: JSValue) -> JSValue
	func isReadable(_ pathstr: JSValue) -> JSValue
	func isWritable(_ pathstr: JSValue) -> JSValue
	func isExecutable(_ pathstr: JSValue) -> JSValue
	func isDeletable(_ pathstr: JSValue) -> JSValue
	func isAccessible(_ pathstr: JSValue, _ acctype: JSValue) -> JSValue

	var currentDirectory:   		JSValue { get }
	var documentDirectory:  		JSValue { get }
	var libraryDirectory:   		JSValue { get }
	var applicationSupportDirectory:	JSValue { get }
	var temporaryDirectory: 		JSValue { get }
	var resourceDirectory:  		JSValue { get }
}

@objc public class KLFileManager: NSObject, KLFileManagerProtocol
{
	private var mContext:			KEContext
	private var mConsole:			CNFileConsole

	public init(context ctxt: KEContext, input ifile: CNFile, output ofile: CNFile, error efile: CNFile){
		mContext		= ctxt
		mConsole		= CNFileConsole(input: ifile, output: ofile, error: efile)
	}

	public func open(_ pathval: JSValue, _ accval: JSValue) -> JSValue
	{
		guard let acctype = decodeAccessType(accval) else {
			CNLog(logLevel: .error, message: "Invalid file access type")
			return JSValue(nullIn: mContext)
		}

		let fmanager = FileManager.default
		if let pathurl = pathval.toURL() {
			switch fmanager.openFile(URL: pathurl, accessType: acctype) {
			case .success(let file):
				let fileobj = KLFile(file: file, context: mContext)
				return JSValue(object: fileobj, in: mContext)
			case .failure(_):
				break // Failed to open
			}
		} else {
			CNLog(logLevel: .error, message: "Invalid path value")
		}
		return JSValue(nullIn: mContext)
	}

	private func decodeAccessType(_ accval: JSValue) -> CNFileAccessType? {
		if accval.isString {
			if let accstr = accval.toString() {
				let result : CNFileAccessType?
				switch accstr {
				case "r":  result = .ReadAccess
				case "w":  result = .WriteAccess
				case "w+": result = .AppendAccess
				default:   result = nil
				}
				return result
			}
		}
		return nil
	}

	public func fileExists(_ pathval: JSValue) -> JSValue {
		let result: Bool
		if let url = pathval.toURL() {
			result = FileManager.default.fileExists(atPath: url.path)
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func isReadable(_ pathval: JSValue) -> JSValue {
		let result: Bool
		if let url = pathval.toURL() {
			result = FileManager.default.isReadableFile(atPath: url.path)
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func isWritable(_ pathval: JSValue) -> JSValue {
		let result: Bool
		if let url = pathval.toURL() {
			result = FileManager.default.isWritableFile(atPath: url.path)
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func isExecutable(_ pathval: JSValue) -> JSValue {
		let result: Bool
		if let url = pathval.toURL() {
			result = FileManager.default.isExecutableFile(atPath: url.path)
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func isDeletable(_ pathval: JSValue) -> JSValue {
		let result: Bool
		if let url = pathval.toURL() {
			result = FileManager.default.isDeletableFile(atPath: url.path)
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func isAccessible(_ pathval: JSValue, _ accval: JSValue) -> JSValue {
		if let pathurl = pathval.toURL(), let accnum  = valueToInt(value: accval) {
			let acctype: CNFileAccessType?
			switch accnum {
			case CNFileAccessType.ReadAccess.rawValue:
				acctype = .ReadAccess
			case CNFileAccessType.WriteAccess.rawValue:
				acctype = .WriteAccess
			case CNFileAccessType.AppendAccess.rawValue:
				acctype = .AppendAccess
			default:
				acctype = nil
			}
			if let type = acctype {
				let result = FileManager.default.isAccessible(pathString: pathurl.path,
									      accessType: type)
				return JSValue(bool: result, in: mContext)
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func fullPath(_ pathval: JSValue, _ baseval: JSValue) -> JSValue {
		if let path = valueToString(value: pathval), let base = baseval.toURL() {
			let url = FileManager.default.fullPath(pathString: path, baseURL: base)
			return JSValue(object: KLURL(URL: url, context: mContext), in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func normalizePath(_ parent: JSValue, _ subdir: JSValue) -> JSValue {
		if let parenturl = parent.toURL(), let subdirstr = valueToString(value: subdir) {
			var url = parenturl.appendingPathComponent(subdirstr)
			url.standardize()
			return JSValue(object: KLURL(URL: url, context: mContext), in: mContext)
		}
		return JSValue(nullIn: mContext)
	}

	public var documentDirectory: JSValue { get {
		let docurl = FileManager.default.documentDirectory
		let urlobj = KLURL(URL: docurl, context: mContext)
		return JSValue(object: urlobj, in: mContext)
	}}

	public var libraryDirectory: JSValue { get {
		let liburl = FileManager.default.libraryDirectory
		let urlobj = KLURL(URL: liburl, context: mContext)
		return JSValue(object: urlobj, in: mContext)
	}}

	public var applicationSupportDirectory: JSValue { get {
		let liburl = FileManager.default.applicationSupportDirectory
		let urlobj = KLURL(URL: liburl, context: mContext)
		return JSValue(object: urlobj, in: mContext)
	}}

	public var currentDirectory: JSValue { get {
		let dir    = CNEnvironment.shared.currentDirectory
		let urlobj = KLURL(URL: dir, context: mContext)
		return JSValue(object: urlobj, in: mContext)
	}}

	public var resourceDirectory: JSValue { get {
		if let url = FileManager.default.resourceDirectory {
			let urlobj = KLURL(URL: url, context: mContext)
			return JSValue(object: urlobj, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}}

	public var temporaryDirectory: JSValue { get {
		let tmpurl = FileManager.default.temporaryDirectory
		let urlobj = KLURL(URL: tmpurl, context: mContext)
		return JSValue(object: urlobj, in: mContext)
	}}

    public func copy(_ fromfile: JSValue, _ tofile: JSValue) -> JSValue {
		guard let fromurl = fromfile.toURL(), let tourl = tofile.toURL() else {
			CNLog(logLevel: .error, message: "Invalid parameter type", atFunction: #function, inFile: #file)
			return JSValue(bool: false, in: mContext)
		}
		let result: Bool
		do {
			try FileManager.default.copyItem(at: fromurl, to: tourl)
			result = true
		} catch {
			let err = error as NSError
			CNLog(logLevel: .error, message: "[Error] \(err.toString())", atFunction: #function, inFile: #file)
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	public func remove(_ file: JSValue) -> JSValue {
		let result: Bool
		if let url = file.toURL() {
			if let err = FileManager.default.removeFile(atURL: url) {
				CNLog(logLevel: .error, message: "[Error] \(err.toString()): \(url.path)",
				      atFunction: #function, inFile: #file)
				result = false
			} else {
				// no error
				result = true
			}
		} else {
			result = false
		}
		return JSValue(bool: result, in: mContext)
	}

	private func pathString(in val: JSValue) -> String? {
		if let str = val.toString() {
			return str
		} else if let obj = val.toObject() {
			if let urlobj = obj as? KLURL {
				if let url = urlobj.url {
					return url.path
				}
			}
		}
		return nil
	}

	public func uti(_ pathval: JSValue) -> JSValue {
		if pathval.isString {
			if let pathstr = pathval.toString() {
				let pathurl = URL(fileURLWithPath: pathstr)
				if let uti = CNFilePath.UTIForFile(URL: pathurl) {
					return JSValue(object: uti, in: mContext)
				}
			}
		}
		return JSValue(nullIn: mContext)
	}

	public func checkFileType(_ pathval: JSValue) -> JSValue {
		if let pathstr = valueToString(value: pathval) {
			let fmanager = FileManager.default
                        let result: JSValue
                        switch fmanager.checkFileType(pathString: pathstr) {
                        case .success(let ftype):
                                result = JSValue(int32: Int32(ftype.rawValue), in: self.mContext)
                        case .failure(let err):
                                CNLog(logLevel: .error, message: err.toString(), atFunction: #function, inFile: #file)
                                result = JSValue(nullIn: self.mContext)
                        }
                        return result
		}
                return JSValue(nullIn: mContext)
	}

	private func valueToString(value val: JSValue) -> String? {
		if val.isURL {
			if let url = val.toURL() {
				return url.path
			} else {
				return nil
			}
		} else if val.isString {
			return val.toString()
		} else {
			return nil
		}
	}

	private func valueToInt(value val: JSValue) -> Int? {
		if val.isNumber {
			return Int(val.toInt32())
		} else {
			return nil
		}
	}
}
