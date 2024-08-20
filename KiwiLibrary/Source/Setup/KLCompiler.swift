/**
 * @file	KLCompiler.swift
 * @brief	Define KLCompiler class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import CoconutDatabase
import JavaScriptCore
#if os(OSX)
import AppKit
#else
import UIKit
#endif
import Foundation

open class KLLibraryCompiler: KECompiler
{
	open func compile(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		guard compileBase(context: ctxt, console: cons, config: conf) else {
			CNLog(logLevel: .error, message: "[Error] Failed to compile: base", atFunction: #function, inFile: #file)
			return false
		}

		guard compileGeneralFunctions(context: ctxt, resource: res, console: cons, environment: env, config: conf) else {
			CNLog(logLevel: .error, message: "[Error] Failed to compile: general functions", atFunction: #function, inFile: #file)
			return false
		}
		guard compileThreadFunctions(context: ctxt, resource: res, console: cons, environment: env, config: conf) else {
			CNLog(logLevel: .error, message: "[Error] Failed to compile: thread functions", atFunction: #function, inFile: #file)
			return false
		}
		guard compileBuiltinScripts(context: ctxt, console: cons, config: conf) else {
			CNLog(logLevel: .error, message: "[Error] Failed to compile: built-in scripts", atFunction: #function, inFile: #file)
			return false
		}
		guard compileUserScripts(context: ctxt, resource: res, console: cons, config: conf) else {
			CNLog(logLevel: .error, message: "[Error] Failed to compile: user scripts", atFunction: #function, inFile: #file)
			return false
		}
		return true
	}

	private func compileGeneralFunctions(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		defineConstants(context: ctxt)
		defineFunctions(context: ctxt, console: cons, config: conf)
		defineStringFunctions(context: ctxt, console: cons, config: conf)
		definePrimitiveObjects(context: ctxt, console: cons, config: conf)
		defineClassObjects(context: ctxt, console: cons, config: conf)
		defineGlobalObjects(context: ctxt, console: cons, environment: env, config: conf)
		defineConstructors(context: ctxt, resource: res, console: cons, config: conf)
		defineDatabase(context: ctxt, console: cons, config: conf)
		return true
	}

	private func compileThreadFunctions(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		if defineThreadFunction(context: ctxt, resource: res, console: cons, environment: env, config: conf) {
			return (ctxt.errorCount == 0)
		} else {
			return false
		}
	}

	private func compileBuiltinScripts(context ctxt: KEContext, console cons: CNFileConsole, config conf: KEConfig) -> Bool {
		importBuiltinLibrary(context: ctxt, console: cons, config: conf)
		return (ctxt.errorCount == 0)
	}

	private func compileUserScripts(context ctxt: KEContext, resource res: KEResource, console cons: CNConsole, config conf: KEConfig) -> Bool {
		if compileLibraryFiles(context: ctxt, resource: res, console: cons, config: conf) {
			return (ctxt.errorCount == 0)
		} else {
			return false
		}
	}

	private func compileLibraryFiles(context ctxt: KEContext, resource res: KEResource, console cons: CNConsole, config conf: KEConfig) -> Bool {
		/* Compile library */
		var result = true
        for url in res.libraries() {
            if let scr = url.loadContents() as? String {
                let _  = self.compileStatement(context: ctxt, statement: scr, sourceFile: url, console: cons, config: conf)
            } else {
                cons.error(string: "Failed to load script from \(url.path)")
                result = false
            }
        }
		return result && (ctxt.errorCount == 0)
	}

	private func defineConstants(context ctxt: KEContext) {
		/* PI */
		if let pival = JSValue(double: Double.pi, in: ctxt){
			ctxt.set(name: "PI", value: pival)
		}
	}

	private func defineFunctions(context ctxt: KEContext, console cons: CNConsole, config conf: KEConfig) {
		/* isUndefined */
		let isUndefinedFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isUndefined
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isUndefined", function: isUndefinedFunc)

		/* isNull */
		let isNullFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isNull
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isNull", function: isNullFunc)

		/* isBoolean */
		let isBooleanFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isBoolean
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isBoolean", function: isBooleanFunc)

		/* toBoolean */
		let toBooleanFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isBoolean {
				return value
			} else if value.isNumber {
				if let num = value.toNumber() {
					return JSValue(bool: num.intValue != 0, in: ctxt)
				} else {
					return JSValue(nullIn: ctxt)
				}
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toBoolean", function: toBooleanFunc)

		/* isNumber */
		let isNumberFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isNumber
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isNumber", function: isNumberFunc)

		/* toNumber */
		let toNumberFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isNumber {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toNumber", function: toNumberFunc)

		/* isString */
		let isStringFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isString
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isString", function: isStringFunc)

		/* toString */
		let toStringFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isString {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toString", function: toStringFunc)

		/* isObject */
		let isObjectFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isObject
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isObject", function: isObjectFunc)

		/* toObject */
		let toObjectFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isObject {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toObject", function: toObjectFunc)

		/* isArray */
		let isArrayFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isArray
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isArray", function: isArrayFunc)

		/* toArray */
		let toArrayFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isArray {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toArray", function: toArrayFunc)

		/* isDictionary */
		let isDictFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			var result: Bool = false
			if value.isObject {
				if let _ = value.toObject() as? Dictionary<String, Any> {
					result = true
				}
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isDictionary", function: isDictFunc)

		/* toDictionary */
		let toDictFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isObject {
				if let _ = value.toObject() as? Dictionary<String, Any> {
					return value
				}
			}
			return JSValue(nullIn: ctxt)
		}
		ctxt.set(name: "toDictionary", function: toDictFunc)

		/* isRecord */
		let isRecordFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			return JSValue(bool: value.isRecord, in: ctxt)
		}
		ctxt.set(name: "isRecord", function: isRecordFunc)

		/* toRecord */
		let toRecordFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isRecord {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toRecord", function: toRecordFunc)

		/* isDate */
		let isDateFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isDate
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isDate", function: isDateFunc)

		/* toDate */
		let toDateFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isDate {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toDate", function: toDateFunc)

		/* isURL */
		let isURLFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isURL
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isURL", function: isURLFunc)

		/* toURL */
		let toURLFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isURL {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toURL", function: toURLFunc)

		/* isPoint */
		let isPointFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			return JSValue(bool: value.isPoint, in: ctxt)
		}
		ctxt.set(name: "isPoint", function: isPointFunc)

		/* toPoint */
		let toPointFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isPoint {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toPoint", function: toPointFunc)

		/* isSize */
		let isSizeFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isSize
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isSize", function: isSizeFunc)

		/* toSize */
		let toSizeFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isSize {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toSize", function: toSizeFunc)

		/* isRect */
		let isRectFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isRect
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isRect", function: isRectFunc)

		/* toRect */
		let toRectFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isRect {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toRect", function: toRectFunc)

		/* isOval */
		let isOvalFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isOval
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isOval", function: isOvalFunc)

		/* toOval */
		let toOvalFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isOval {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toOval", function: toOvalFunc)

		/* isVector */
		let isVectorFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isVector
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isVector", function: isVectorFunc)

		/* toVector */
		let toVectorFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isVector {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toVector", function: toVectorFunc)

		/* isBitmap */
		let isBitmapFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: Bool = value.isBitmap
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isBitmap", function: isBitmapFunc)

		/* toBitmap */
		let toBitmapFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isBitmap {
				return value
			} else {
				return JSValue(nullIn: ctxt)
			}
		}
		ctxt.set(name: "toBitmap", function: toBitmapFunc)

		/* toText */
		let toTextFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			let result: KLTextProtocol
			let txt = value.toScript()
			if let line = txt as? CNTextLine {
				result = KLTextLine(text: line, context: ctxt)
			} else if let sect = txt as? CNTextSection {
				result = KLTextSection(text: sect, context: ctxt)
			} else if let table = txt as? CNTextTable {
				result = KLTextTable(text: table, context: ctxt)
			} else {
				let line = CNTextLine(string: "\(value)")
				result = KLTextLine(text: line, context: ctxt)
			}
			return JSValue(object: result, in: ctxt)
		}
		ctxt.set(name: "toText", function: toTextFunc)

		/* isEOF */
		let isEofFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			var result = false
			if value.isString {
				if let str = value.toString() {
					result = CNFile.isEOF(str)
				}
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isEOF", function: isEofFunc)

		/* asciiCodeName */
		let asciiNameFunc: @convention(block) (_ value: JSValue) -> JSValue = {
			(_ value: JSValue) -> JSValue in
			if value.isNumber {
				let code = value.toInt32()
				if let name = Character.asciiCodeName(code: Int(code)) {
					return JSValue(object: name, in: ctxt)
				}
			}
			return JSValue(nullIn: ctxt)
		}
		ctxt.set(name: "asciiCodeName", function: asciiNameFunc)

		/* sleep */
		let sleepFunc: @convention(block) (_ val: JSValue) -> JSValue = {
			(_ val: JSValue) -> JSValue in
			let result: Bool
			if val.isNumber {
				Thread.sleep(forTimeInterval: val.toDouble())
				result = true
			} else {
				result = false
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "sleep", function: sleepFunc)

		/* openURL */
		let openURLFunc: @convention(block) (_ urlval: JSValue,  _ cbfunc: JSValue) -> JSValue = {
			(_ urlval: JSValue,  _ cbfunc: JSValue) -> JSValue in
			if let url = self.valueToURL(value: urlval) {
				CNExecuteInMainThread(doSync: false, execute: {
					() -> Void in
					CNWorkspace.open(URL: url, callback: {
						(_ result: Bool) -> Void in
						if let param = JSValue(bool: result, in: ctxt) {
							if !cbfunc.isNull {
								cbfunc.call(withArguments: [param])
							}
						}

					})
				})
			}
			return JSValue(nullIn: ctxt)
		}
		ctxt.set(name: "_openURL", function: openURLFunc)

		/* exit */
		let exitFunc: @convention(block) (_ value: JSValue) -> JSValue
		switch conf.applicationType {
		case .terminal:
			exitFunc = {
				(_ value: JSValue) -> JSValue in
				let ecode: Int32
				if value.isNumber {
					ecode = value.toInt32()
				} else {
					cons.error(string: "Invalid parameter for exit() function")
					ecode = 1
				}
				Darwin.exit(ecode)
			}
			ctxt.set(name: "exit", function: exitFunc)
		case .window:
			#if os(OSX)
				exitFunc = {
					[weak self] (_ value: JSValue) -> JSValue in
					if let myself = self {
						CNExecuteInMainThread(doSync: true, execute: {
							() -> Void in
							NSApplication.shared.terminate(myself)
						})
					}
					return JSValue(undefinedIn: ctxt)
				}
			#else
				/* The method to quit iOS application is NOT defined */
				exitFunc = {
					(_ value: JSValue) -> JSValue in
					return JSValue(undefinedIn: ctxt)
				}
			#endif
			ctxt.set(name: "exit", function: exitFunc)
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown application type", atFunction: #function, inFile: #file)
			break
		}

		/* _select_exit_code */
		let selExitFunc: @convention(block) (_ val0: JSValue, _ val1: JSValue) -> JSValue = {
			(_ val0: JSValue, _ val1: JSValue) -> JSValue in
			let result: Int32
			if val0.isNumber && val1.isNumber {
				let code0 = val0.toInt32()
				let code1 = val1.toInt32()
				if code0 != 0 {
					result = code0
				} else if code1 != 0 {
					result = code1
				} else {
					result = 0
				}
			} else {
				CNLog(logLevel: .error, message: "Invalid parameter for exit() function")
				result = -1
			}
			return JSValue(int32: result, in: ctxt)
		}
		ctxt.set(name: "_select_exit_code", function: selExitFunc)

		/* tokenize */
		let tokenizefunc:  @convention(block) (_ str: JSValue) -> JSValue = {
			(_ str: JSValue) -> JSValue in return KLToken.stringToToken(str, context: ctxt)
		}
		ctxt.set(name: "tokenize", function: tokenizefunc)
	}

	private func defineStringFunctions(context ctxt: KEContext, console cons: CNConsole, config conf: KEConfig) {
		/* isSpace */
		let isSpaceFunc: @convention(block) (_ val: JSValue) -> JSValue = {
			(_ val: JSValue) -> JSValue in
			let result: Bool
			if let str = KLLibraryCompiler.valueToString(value: val) {
				result = str.isWhiteSpace
			} else {
				result = false
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isSpace", function: isSpaceFunc)

		/* isNumber */
		let isNumberFunc: @convention(block) (_ val: JSValue) -> JSValue = {
			(_ val: JSValue) -> JSValue in
			let result: Bool
			if let str = KLLibraryCompiler.valueToString(value: val) {
				result = str.isNumber
			} else {
				result = false
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isNumber", function: isNumberFunc)

		/* isAlphaNumerics */
		let isAlphaNumericsFunc: @convention(block) (_ val: JSValue) -> JSValue = {
			(_ val: JSValue) -> JSValue in
			let result: Bool
			if let str = KLLibraryCompiler.valueToString(value: val) {
				result = str.isAlphaNumerics
			} else {
				result = false
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isAlphaNumerics", function: isAlphaNumericsFunc)

		/* isIdentifier */
		let isIdentifierFunc: @convention(block) (_ val: JSValue) -> JSValue = {
			(_ val: JSValue) -> JSValue in
			let result: Bool
			if let str = KLLibraryCompiler.valueToString(value: val) {
				result = str.isIdentifier
			} else {
				result = false
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: "isIdentifier", function: isIdentifierFunc)
	}

	private func definePrimitiveObjects(context ctxt: KEContext, console cons: CNConsole, config conf: KEConfig) {
		/* Point */
		let pointFunc: @convention(block) (_ xval: JSValue, _ yval: JSValue) -> JSValue = {
			(_ xval: JSValue, _ yval: JSValue) -> JSValue in
			if let point = CGPoint.fromJSValue(xval, yval) {
				return point.toJSValue(context: ctxt)
			} else {
				cons.error(string: "Invalid parameter for Point constructor\n")
				return JSValue(undefinedIn: ctxt)
			}
		}
		ctxt.set(name: "Point", function: pointFunc)

		/* Size */
		let sizeFunc: @convention(block) (_ wval: JSValue, _ hval: JSValue) -> JSValue = {
			(_ wval: JSValue, _ hval: JSValue) -> JSValue in
			if let size = CGSize.fromJSValue(wval, hval) {
				return size.toJSValue(context: ctxt)
			} else {
				cons.error(string: "Invalid parameter for Size constructor\n")
				return JSValue(undefinedIn: ctxt)
			}
		}
		ctxt.set(name: "Size", function: sizeFunc)


		/* Rect */
		let rectFunc: @convention(block) (_ xval: JSValue, _ yval: JSValue, _ widthval: JSValue, _ heightval: JSValue) -> JSValue = {
			(_ xval: JSValue, _ yval: JSValue, _ widthval: JSValue, _ heightval: JSValue) -> JSValue in
			if let rect = CGRect.fromJSValue(xval, yval, widthval, heightval) {
				return rect.toJSValue(context: ctxt)
			} else {
				cons.error(string: "Invalid parameter for Rect constructor\n")
				return JSValue(undefinedIn: ctxt)
			}
		}
		ctxt.set(name: "Rect", function: rectFunc)

		/* Oval */
		let ovalFunc: @convention(block) (_ xval: JSValue, _ yval: JSValue, _ radval: JSValue) -> JSValue = {
			(_ xval: JSValue, _ yval: JSValue, _ radval: JSValue) -> JSValue in
			if let oval = CNOval.fromJSValue(xval, yval, radval) {
				return oval.toJSValue(context: ctxt)
			} else {
				cons.error(string: "Invalid parameter for Oval constructor\n")
				return JSValue(undefinedIn: ctxt)
			}
		}
		ctxt.set(name: "Oval", function: ovalFunc)

		/* Vector */
		let vectorFunc: @convention(block) (_ dxval: JSValue, _ dyval: JSValue) -> JSValue = {
			(_ dxval: JSValue, _ dyval: JSValue) -> JSValue in
			let result: CGVector
			if let vec = CGVector.fromJSValue(dxval, dyval) {
				result = vec
			} else {
				CNLog(logLevel: .error, message: "Invalid parameter for Vector function")
				result = CGVector(dx: 0.0, dy: 0.0)
			}
			return result.toJSValue(context: ctxt)
		}
		ctxt.set(name: "Vector", function: vectorFunc)
	}

	private func defineClassObjects(context ctxt: KEContext, console cons: CNFileConsole, config conf: KEConfig) {
		/* Pipe() */
		let pipeFunc:  @convention(block) () -> JSValue = {
			() -> JSValue in
			let pipe = KLPipe(context: ctxt)
			return JSValue(object: pipe, in: ctxt)
		}
		ctxt.set(name: "Pipe", function: pipeFunc)

		/* File */
		let file = KLFileManager(context: 	ctxt,
					 input:   	cons.inputFile,
					 output:  	cons.outputFile,
					 error:   	cons.errorFile)
		ctxt.set(name: "FileManagerCore", object: file)

		let stdin = KLFile(file: cons.inputFile, context: ctxt)
		ctxt.set(name: KLFile.StdInName, object: stdin)

		let stdout = KLFile(file: cons.outputFile, context: ctxt)
		ctxt.set(name: KLFile.StdOutName, object: stdout)

		let stderr = KLFile(file: cons.errorFile, context: ctxt)
		ctxt.set(name: KLFile.StdErrName, object: stderr)

		/* Color manager */
		let cols = KLColors(context: ctxt)
		ctxt.set(name: "Colors", object: cols)

		/* TerminalController */
		let tcont = CNFileTerminalController(console: cons)
		let thdr  = KLTerminalController(controller: tcont, context: ctxt)
		ctxt.set(name: "TerminalController", object: thdr)

		/* Curses */
		let curses = KLCurses(console: cons, context: ctxt)
		ctxt.set(name: "Curses", object: curses)

		/* FontManager */
		let fontmgr = KLFontManager(context: ctxt)
		ctxt.set(name: "FontManager", object: fontmgr)

		/* ValueFile */
		let native = KLNativeValueFile(context: ctxt)
		ctxt.set(name: "_JSONFile", object: native)

		/* Char */
		let charobj = KLChar(context: ctxt)
		ctxt.set(name: "Char", object: charobj)

		/* Preference */
		let pref = KLPreference(context: ctxt)
		ctxt.set(name: "Preference", object: pref)

		/* EscapeSequences */
		let eseq = KLEscapeSequences(context: ctxt)
		ctxt.set(name: "EscapeSequences", object: eseq)
	}

	private func defineGlobalObjects(context ctxt: KEContext, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) {
		/* console */
		let newcons = KLConsole(context: ctxt, console: cons)
		ctxt.set(name: "console", object: newcons)

		/* Environment */
		let envobj = KLEnvironment(environment: env, context: ctxt)
		ctxt.set(name: "env", object: envobj)
	}

        private func defineConstructors(context ctxt: KEContext, resource res: KEResource, console cons: CNConsole, config conf: KEConfig) {
                /* URL */
                let urlFunc: @convention(block) (_ value: JSValue) -> JSValue = {
                        (_ value: JSValue) -> JSValue in
                        if let str = value.toString() {
                                let url: URL?
                                if let _ = FileManager.default.schemeInPath(pathString: str) {
                                        url = URL(string: str)
                                } else {
                                        url = URL(fileURLWithPath: str)
                                }
                                if let u = url {
                                        return JSValue(URL: u, in: ctxt)
                                }
                        }
                        cons.error(string: "Invalid parameter for URL: \(value.description)")
                        return JSValue(nullIn: ctxt)
                }
                ctxt.set(name: "URL", function: urlFunc)

                /* Bitmap */
                let allocBitmapFunc: @convention(block) (_ value: JSValue) -> JSValue = {
                        (_ value: JSValue) -> JSValue in
                        var result: KLBitmapData? = nil
                        if value.isBitmap {
                                result = value.toBitmap()
                        } else if value.isObject {
                                if let arr = value.toObject() as? Array<Array<Any>> {
                                        var cols: Array<Array<CNColor>> = []
                                        for arr0 in arr {
                                                var cols1: Array<CNColor> = []
                                                for elm1 in arr0 {
                                                        if let elm2 = elm1 as? Dictionary<String, Any> {
                                                                if let col = CNColor.fromValue(dictionary: elm2) {
                                                                        cols1.append(col)
                                                                }
                                                        }
                                                }
                                                cols.append(cols1)
                                        }
                                        let bm   = CNBitmapData(colorData: cols)
                                        result = KLBitmapData(bitmap: bm, context: ctxt)
                                }
                        }
                        if let r = result {
                                return JSValue(object: r, in: ctxt)
                        } else {
                                return JSValue(nullIn: ctxt)
                        }
                }
                ctxt.set(name: "Bitmap", function: allocBitmapFunc)

                /* Properties */
                let propFunc: @convention(block) (_ nameval: JSValue) -> JSValue = {
                        (_ nameval: JSValue) -> JSValue in
                        guard let name = nameval.toString() else {
                                cons.error(string: "property name is required for Properties() constructor\n")
                                return JSValue(nullIn: ctxt)
                        }
                        guard let prop = res.properties(identifier: name) else {
                                cons.error(string: "Failed to load property file named: \(name)")
                                return JSValue(nullIn: ctxt)
                        }
                        return JSValue(object: KLProperties(properties: prop, context: ctxt), in: ctxt)
                }
                ctxt.set(name: "Properties", function: propFunc)

                /* StringStream */
                let allocStringStreamFunc: @convention(block) (_ strval: JSValue) -> JSValue = {
                        (_ strval: JSValue) -> JSValue in
                        if strval.isString {
                                let strm = KLStringStream(string: strval.toString(), context: ctxt)
                                return JSValue(object: strm, in: ctxt)
                        } else {
                                CNLog(logLevel: .error, message: "Failed to allocate object", atFunction: #function, inFile: #file)
                                return JSValue(nullIn: ctxt)
                        }
                }
                ctxt.set(name: "StringStream", function: allocStringStreamFunc)

                /* TextLine */
                let textLineFunc: @convention(block) (_ str: JSValue) -> JSValue = {
                        (_ str: JSValue) -> JSValue in
                        let txt = CNTextLine(string: str.toString())
                        return JSValue(object: KLTextLine(text: txt, context: ctxt), in: ctxt)
                }
                ctxt.set(name: "TextLine", function: textLineFunc)

                /* TextSection */
                let textSectionFunc: @convention(block) () -> JSValue = {
                        () -> JSValue in
                        let txt = CNTextSection()
                        return JSValue(object: KLTextSection(text: txt, context: ctxt), in: ctxt)
                }
                ctxt.set(name: "TextSection", function: textSectionFunc)

                /* TextRecord */
                let textRecordFunc: @convention(block) () -> JSValue = {
                        () -> JSValue in
                        let txt = CNTextRecord()
                        return JSValue(object: KLTextRecord(text: txt, context: ctxt), in: ctxt)
                }
                ctxt.set(name: "TextRecord", function: textRecordFunc)

                /* Table */
                let tableFunc: @convention(block) (_ nameval: JSValue) -> JSValue = {
                        (_ nameval: JSValue) -> JSValue in
                        guard let name = nameval.toString() else {
                                cons.error(string: "table name is required for Table() constructor\n")
                                return JSValue(nullIn: ctxt)
                        }
                        guard let table = res.table(identifier: name) else {
                                cons.error(string: "Failed to load table named: \(name)")
                                return JSValue(nullIn: ctxt)
                        }
                        return JSValue(object: KLTable(table: table, context: ctxt), in: ctxt)
                }
                ctxt.set(name: "Table", function: tableFunc)

                /* TextTable */
                let textTableFunc: @convention(block) () -> JSValue = {
                        () -> JSValue in
                        let txt = CNTextTable()
                        return JSValue(object: KLTextTable(text: txt, context: ctxt), in: ctxt)
                }
                ctxt.set(name: "TextTable", function: textTableFunc)

                /* Icon */
                let iconFunc: @convention(block) (_ tagval: JSValue, _ symval: JSValue, _ labval: JSValue) -> JSValue = {
                        (_ tagval: JSValue, _ symval: JSValue, _ labval: JSValue) -> JSValue in
                        if let icon = KLIcon.encode(tag: tagval, symbol: symval, title: labval, context: ctxt) {
                                return JSValue(object: KLIcon(core: icon, context: ctxt), in: ctxt)
                        } else {
                                CNLog(logLevel: .error, message: "Failed to encode icon", atFunction: #function, inFile: #file)
                                return JSValue(nullIn: ctxt)
                        }
                }
                ctxt.set(name: "Icon", function: iconFunc)

                /* SpriteActions */
                let spriteActionsFunc: @convention(block) () -> JSValue = {
                        () -> JSValue in
                        let newacts = KLSpriteActions(actions: CNSpriteActions())
                        return JSValue(object: newacts, in: ctxt)

                }
                ctxt.set(name: "SpriteActions", function: spriteActionsFunc)

                /* MenuItem */
                let menuItemFunc: @convention(block) (_ title: JSValue, _ value: JSValue) -> JSValue = {
                        (_ title: JSValue, _ value: JSValue) -> JSValue in
                        let newitem: CNMenuItem
                        if let str = title.toString(), let val = value.toNumber() {
                                newitem = CNMenuItem(title: str, value: val.intValue)
                        } else {
                                cons.error(string: "Invalid parameter for MenuItem function")
                                newitem = CNMenuItem(title: "?", value: 0)
                        }
                        let newobj = KLMenuItem(menuItem: newitem, context: ctxt)
                        return JSValue(object: newobj, in: ctxt)
                }
                ctxt.set(name: "MenuItem", function: menuItemFunc)
	}

	private func importBuiltinLibrary(context ctxt: KEContext, console cons: CNConsole, config conf: KEConfig)
	{
		if let url = CNFilePath.URLForResourceFile(fileName: "KiwiLibrary", fileExtension: "js", subdirectory: "Library", forClass: KLLibraryCompiler.self) {
			do {
				let script = try String(contentsOf: url, encoding: .utf8)
				let _ = compileStatement(context: ctxt, statement: script, sourceFile: url, console: cons, config: conf)
			} catch {
				cons.error(string: "Failed to compile \"KiwiLibrary.js\"")
			}
		} else {
			cons.error(string: "Built-in script \"KiwiLibrary.js\" is not found.")
		}
	}

	private func defineThreadFunction(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		/* Thread: name: Identifier in the resource */
		let thfunc: @convention(block) (_ nameval: JSValue, _ consval: JSValue) -> JSValue = {
			(_ nameval: JSValue, _ consval: JSValue) -> JSValue in
			if let name = nameval.toString(),
			   let cons = self.valueToConsole(value: consval) {
				if let scrurl = res.thread(identifier: name) {
					return self.runThread(scriptFile: scrurl, resource: res, context: ctxt, console: cons, environment: env, config: conf)
				} else {
					CNLog(logLevel: .error, message: "Thread \(name) is NOT found in resource", atFunction: #function, inFile: #file)
				}
			} else {
				CNLog(logLevel: .error, message: "Unexpected parameters", atFunction: #function, inFile: #file)
			}
			return JSValue(nullIn: ctxt)
		}
		ctxt.set(name: "_Thread", function: thfunc)

		/* _runThread */
		let runfunc: @convention(block) (_ pathval: JSValue, _ consval: JSValue) -> JSValue = {
			(_ pathval: JSValue, _ consval: JSValue) -> JSValue in
			if let path = self.valueToFullPath(path: pathval),
			   let cons = self.valueToConsole(value: consval) {
				switch self.resourceFromFile(path) {
				case .success(let resource):
					switch self.mainScriptInResource(resource) {
					case .success(let script):
						return self.runThread(scriptFile: script, resource: resource, context: ctxt, console: cons, environment: env, config: conf)
					case .failure(let err):
						cons.print(string: "[Error] \(err.toString())\n")
					}
				case .failure(let err):
					cons.print(string: "[Error] \(err.toString())\n")
				}
			} else {
				CNLog(logLevel: .error, message: "Unexpected parameters", atFunction: #function, inFile: #file)
			}
			return JSValue(nullIn: ctxt)
		}
		ctxt.set(name: "_runThread", function: runfunc)
		return true
	}

	private func runThread(scriptFile scrurl: URL, resource res: KEResource, context ctxt: KEContext, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> JSValue {
		let thread = KLScriptThread(scriptFile: scrurl, resource: res, virtualMachine: ctxt.virtualMachine, console: cons, environment: env, config: conf)
		let obj = KLThread(thread: thread, context: ctxt)
		return JSValue(object: obj, in: ctxt)
	}

	private func defineDatabase(context ctxt: KEContext, console cons: CNConsole, config conf: KEConfig) {
		/* ContactDatabase */
		let contact = KLContactDatabase(context: ctxt)
		ctxt.set(name: "Contacts", object: contact)
	}

	#if os(OSX)
	private enum Application {
	case textEdit
	case safari
	case other
	}

	private func applicationKind(application app: NSRunningApplication) -> Application {
		var result: Application = .other
		if let ident = app.bundleIdentifier {
			switch ident {
			case "com.apple.TextEdit":
				result = .textEdit
			case "com.apple.Safari":
				result = .safari
			default:
				break
			}
		}
		return result
	}

	#endif

	private class func valueToString(value val: JSValue) -> String? {
		if val.isString	{
			return val.toString()
		} else {
			return nil
		}
	}

	public func valueToURL(value val: JSValue) -> URL? {
		if val.isString {
			if let str = val.toString() {
				return URL(string: str)
			}
		} else if val.isObject {
			if let obj = val.toObject() as? KLURL {
				return obj.url
			}
		}
		return nil
	}

	private class func valueToURLs(URLvalues urlval: JSValue, console cons: CNConsole) -> Array<URL>? {
		if urlval.isArray {
			var result: Array<URL> = []
			for val in urlval.toArray() {
				if let url = anyToURL(anyValue: val) {
					result.append(url)
				} else {
					let classname = type(of: val)
					cons.error(string: "Failed to get url: \(classname)\n")
					return nil
				}
			}
			return result
		}
		cons.error(string: "Invalid URL parameters\n")
		return nil
	}

	private class func anyToURL(anyValue val: Any) -> URL? {
		var result: URL? = nil
		if let urlobj = val as? KLURL {
			if let url = urlobj.url {
				result = url
			}
		} else if let urlval = val as? JSValue {
			if let urlobj = urlval.toObject() as? KLURL {
				if let url = urlobj.url {
					result = url
				}
			} else if urlval.isString {
				if let str = urlval.toString() {
					result  = URL(fileURLWithPath: str)
				}
			}
		}
		return result
	}

	#if os(OSX)
	private class func anyToProcess(anyValue val: Any) -> KLProcessProtocol? {
		if let proc = val as? KLProcessProtocol {
			return proc
		} else if let procval = val as? JSValue {
			if procval.isObject {
				if let procobj = procval.toObject() {
					return anyToProcess(anyValue: procobj)
				}
			}
		}
		return nil
	}
	#endif

	public func valueToConsole(value val: JSValue) -> CNFileConsole? {
		if let obj = val.toObject() {
			if let cons = obj as? KLConsole {
				return cons.console
			}
		}
		return nil
	}

	private func valueToFullPath(path pathval: JSValue) -> URL? {
		if let url = pathval.toURL() {
			return url
		} else if let pathstr = pathval.toString() {
			if FileManager.default.isAbsolutePath(pathString: pathstr) {
				return URL(fileURLWithPath: pathstr)
			} else {
				let curdir = CNEnvironment.shared.currentDirectory
				return URL(fileURLWithPath: pathstr, relativeTo: curdir)
			}
		} else {
			return nil
		}
	}

	private func resourceFromFile(_ packdir: URL) -> Result<KEResource, NSError> {
		guard packdir.hasDirectoryPath else {
			let err = NSError.fileError(message: "The parameter must be directory: \(packdir.path)")
			return .failure(err)
		}
		let res = KEResource(packageDirectory: packdir)
		if let err = res.loadManifest() {
			let err = NSError.fileError(message: "Failed to load resource from \(packdir.path): \(err.toString())")
			return .failure(err)
		} else {
			return .success(res)
		}
	}

	private func mainScriptInResource(_ res: KEResource) -> Result<URL, NSError> {
		if let url = res.application() {
			return .success(url)
		} else {
			let err = NSError.fileError(message: "No application section in resource: \(res.packageDirectory.path())")
			return .failure(err)
		}
	}
}

