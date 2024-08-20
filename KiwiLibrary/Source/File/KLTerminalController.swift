/**
 * @file	KLTerminalController.swift
 * @brief	Define KLTerminalController. class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import JavaScriptCore
import CoconutData
import Foundation

@objc public protocol KLTerminalControllerProtocol: JSExport
{
	func execute() -> JSValue

	func string(_ str: JSValue)
	func newline()
	func tab()
	func backspace()
	func delete()
	func insertSpace(_ num: JSValue)
	func cursorUp(_ line: JSValue)
	func cursorDown(_ line: JSValue)
	func cursorForward(_ line: JSValue)
	func cursorBackward(_ line: JSValue)
	func cursorNextLine(_ line: JSValue)
	func cursorPreviousLine(_ line: JSValue)
	func cursorHolizontalAbsolute(_ line: JSValue)
	func cursorVisible(_ line: JSValue)
	func saveCursorPosition()
	func restoreCursorPosition()
	func cursorPosition(_ row: JSValue, _ column: JSValue)	// Started from 1
	func eraceFromCursorToEnd()
	func eraceFromCursorToBegin()
	func eraceEntireBuffer()
	func eraceFromCursorToRight()
	func eraceFromCursorToLeft()
	func eraceEntireLine()
	func scrollUp(_ line: JSValue)
	func scrollDown(_ line: JSValue)
	func resetAll()
	func resetCharacterAttribute()
	func boldCharacter(_ enable: JSValue)
	func underlineCharacter(_ enable: JSValue)
	func blinkCharacter(_ enable: JSValue)
	func reverseCharacter(_ enable: JSValue)
	func foregroundColor(_ color: JSValue)
	func defaultForegroundColor()
	func backgroundColor(_ color: JSValue)
	func defaultBackgroundColor()
	func requestScreenSize()
	func screenSize(_ width: JSValue, _ height:JSValue)
	func selectAltScreen(_ enable: JSValue)
	func setFontStyle(_ style: JSValue)
	func setFontSize(_ size: JSValue)
}

@objc public class KLTerminalController: NSObject, KLTerminalControllerProtocol, KLEmbeddedObject
{
	private var mTerminalController:	CNTerminalController
	private var mEscapeCodes:	CNEscapeCodes
	private var mContext:		KEContext

	public init(controller ctrl: CNTerminalController, context ctxt: KEContext){
		mTerminalController = ctrl
		mEscapeCodes	    = CNEscapeCodes()
		mContext	    = ctxt
	}

	public func execute() -> JSValue {
		var result: CGSize? = nil
		let codes = mEscapeCodes.codes
		mTerminalController.execute(escapeCodes: codes)
		for ecode in codes {
			switch ecode {
			case .requestScreenSize:
				let (width, height) = mTerminalController.screenSize()
				result = CGSize(width: width, height: height)
			default:
				break
			}
		}
		mEscapeCodes.clear()
		if let res = result {
			return JSValue(size: res, in: mContext)
		} else {
			return JSValue(nullIn: mContext)
		}
	}

	public func string(_ strval: JSValue) {
		if let str = strval.toString() {
			mEscapeCodes.string(str)
		} else {
			CNLog(logLevel: .error, message: "String parameter is required", atFunction: #function, inFile: #file)
		}
	}

	public func newline() {
		mEscapeCodes.newline()
	}

	public func tab() {
		mEscapeCodes.tab()
	}

	public func backspace() {
		mEscapeCodes.backspace()
	}

	public func delete() {
		mEscapeCodes.delete()
	}

	public func insertSpace(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.insertSpace(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for insertSpace", atFunction: #function, inFile: #file)
		}
	}

	public func cursorUp(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.cursorUp(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorUp", atFunction: #function, inFile: #file)
		}
	}

	public func cursorDown(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.cursorDown(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorDown", atFunction: #function, inFile: #file)
		}
	}

	public func cursorForward(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.cursorForward(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorForward", atFunction: #function, inFile: #file)
		}
	}

	public func cursorBackward(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.cursorBackward(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorBackward", atFunction: #function, inFile: #file)
		}
	}

	public func cursorNextLine(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.cursorNextLine(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorNextLine", atFunction: #function, inFile: #file)
		}
	}

	public func cursorPreviousLine(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.cursorPreviousLine(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorPreviousLine", atFunction: #function, inFile: #file)
		}
	}

	public func cursorHolizontalAbsolute(_ pos: JSValue) {
		if let num = valueToInt(value: pos) {
			mEscapeCodes.cursorHolizontalAbsolute(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorHolizontalAbsolute", atFunction: #function, inFile: #file)
		}
	}

	public func cursorVisible(_ flagval: JSValue) {
		if let flag = valueToBool(value: flagval) {
			mEscapeCodes.cursorVisible(flag)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorVisible", atFunction: #function, inFile: #file)
		}
	}

	public func saveCursorPosition() {
		mEscapeCodes.saveCursorPosition()
	}

	public func restoreCursorPosition() {
		mEscapeCodes.restoreCursorPosition()
	}

	public func cursorPosition(_ row: JSValue, _ column: JSValue) {
		if let rnum = valueToInt(value: row), let cnum = valueToInt(value: column) {
			mEscapeCodes.cursorPosition(rnum, cnum)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for cursorPosition", atFunction: #function, inFile: #file)
		}
	}

	public func eraceFromCursorToEnd() {
		mEscapeCodes.eraceFromCursorToEnd()
	}

	public func eraceFromCursorToBegin() {
		mEscapeCodes.eraceFromCursorToBegin()
	}

	public func eraceEntireBuffer() {
		mEscapeCodes.eraceEntireBuffer()
	}

	public func eraceFromCursorToRight() {
		mEscapeCodes.eraceFromCursorToRight()
	}

	public func eraceFromCursorToLeft() {
		mEscapeCodes.eraceFromCursorToLeft()
	}

	public func eraceEntireLine() {
		mEscapeCodes.eraceEntireLine()
	}

	public func scrollUp(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.scrollUp(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for scrollUp", atFunction: #function, inFile: #file)
		}
	}

	public func scrollDown(_ line: JSValue) {
		if let num = valueToInt(value: line) {
			mEscapeCodes.scrollDown(num)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for scrollDown", atFunction: #function, inFile: #file)
		}
	}

	public func resetAll() {
		mEscapeCodes.resetAll()
	}

	public func resetCharacterAttribute() {
		mEscapeCodes.resetCharacterAttribute()
	}

	public func boldCharacter(_ enable: JSValue) {
		if let en = valueToBool(value: enable) {
			mEscapeCodes.boldCharacter(en)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for boldCharacter", atFunction: #function, inFile: #file)
		}
	}

	public func underlineCharacter(_ enable: JSValue) {
		if let en = valueToBool(value: enable) {
			mEscapeCodes.underlineCharacter(en)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for underlineCharacter", atFunction: #function, inFile: #file)
		}
	}

	public func blinkCharacter(_ enable: JSValue) {
		if let en = valueToBool(value: enable) {
			mEscapeCodes.blinkCharacter(en)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for blinkCharacter", atFunction: #function, inFile: #file)
		}
	}

	public func reverseCharacter(_ enable: JSValue) {
		if let en = valueToBool(value: enable) {
			mEscapeCodes.reverseCharacter(en)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for reverseCharacter", atFunction: #function, inFile: #file)
		}
	}

	public func foregroundColor(_ color: JSValue) {
		if let col = valueToColor(value: color) {
			mEscapeCodes.foregroundColor(col)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for foregroundColor", atFunction: #function, inFile: #file)
		}
	}

	public func defaultForegroundColor() {
		mEscapeCodes.defaultForegroundColor()
	}

	public func backgroundColor(_ color: JSValue) {
		if let col = valueToColor(value: color) {
			mEscapeCodes.backgroundColor(col)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for backgroundColor", atFunction: #function, inFile: #file)
		}
	}

	public func defaultBackgroundColor() {
		mEscapeCodes.defaultBackgroundColor()
	}

	public func requestScreenSize() {
		mEscapeCodes.requestScreenSize()
	}

	public func screenSize(_ width: JSValue, _ height: JSValue) {
		if let wnum = valueToInt(value: width), let hnum = valueToInt(value: height) {
			mEscapeCodes.screenSize(wnum, hnum)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for screenSize", atFunction: #function, inFile: #file)
		}
	}

	public func selectAltScreen(_ enable: JSValue) {
		if let en = valueToBool(value: enable) {
			mEscapeCodes.selectAltScreen(en)
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for selectAltScreen", atFunction: #function, inFile: #file)
		}
	}

	public func setFontStyle(_ styleval: JSValue) {
		if let stylenum = valueToInt(value: styleval) {
			if let style = CNFont.Style(rawValue: stylenum) {
				mEscapeCodes.setFontStyle(style)
			} else {
				CNLog(logLevel: .error, message: "Invalid style for setFontStyle", atFunction: #function, inFile: #file)
			}
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for setFontStyle", atFunction: #function, inFile: #file)
		}
	}

	public func setFontSize(_ sizeval: JSValue) {
		if let sizenum = valueToInt(value: sizeval) {
			if let size = CNFont.Size(rawValue: sizenum) {
				mEscapeCodes.setFontSize(size)
			} else {
				CNLog(logLevel: .error, message: "Invalid style for setFontSize", atFunction: #function, inFile: #file)
			}
		} else {
			CNLog(logLevel: .error, message: "Unexpected parameter for setFontSize", atFunction: #function, inFile: #file)
		}
	}

	public func copy(context ctxt: KiwiEngine.KEContext) -> KLEmbeddedObject {
		return KLTerminalController(controller: mTerminalController, context: mContext)
	}

	private func valueToInt(value val: JSValue) -> Int? {
		if val.isNumber {
			if let num = val.toNumber() {
				return num.intValue
			}
		}
		return nil
	}

	private func valueToBool(value val: JSValue) -> Bool? {
		if val.isBoolean{
			return val.toBool()
		} else if val.isNumber {
			if let num = val.toNumber() {
				return num.boolValue
			}
		}
		return nil
	}

	private func valueToColor(value val: JSValue) -> CNColor? {
		if CNColor.isColor(scriptValue: val) {
			return CNColor.fromJSValue(scriptValue: val)
		} else {
			return nil
		}
	}
}
