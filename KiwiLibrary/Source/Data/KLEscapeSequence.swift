/**
 * @file	KLEscapeSequenceswift
 * @brief	Extend  KLEscapeSequence, KLEscapeSequences class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

@objc public protocol KLEscapeSequenceProtocol: JSExport
{
	func toString() -> JSValue
}

@objc public class KLEscapeSequence: NSObject, KLEscapeSequenceProtocol
{
	private var mEscapeSequence:	CNEscapeSequence
	private var mContext:		KEContext

	public init(escapeSequence eseq: CNEscapeSequence, context ctxt: KEContext){
		mEscapeSequence = eseq
		mContext	= ctxt
	}

	public func toString() -> JSValue {
		return JSValue(object: mEscapeSequence.toString(), in: mContext)
	}
}

@objc public protocol KLEscapeSequencesProtocol: JSExport
{
	func string(_ str: JSValue) -> JSValue
	func eot() -> JSValue
	func newline() -> JSValue
	func tab() -> JSValue
	func backspace() -> JSValue
	func delete() -> JSValue
	func insertSpaces(_ cnt: JSValue) -> JSValue
	func cursorUp(_ cnt: JSValue) -> JSValue
	func cursorDown(_ cnt: JSValue) -> JSValue
	func cursorForward(_ cnt: JSValue) -> JSValue
	func cursorBackward(_ cnt: JSValue) -> JSValue
	func cursorNextLine(_ cnt: JSValue) -> JSValue
	func cursorPreviousLine(_ cnt: JSValue) -> JSValue
	func cursorHolizontalAbsolute(_ cnt: JSValue) -> JSValue
	func cursorVisible(_ flg: JSValue) -> JSValue
	func saveCursorPosition() -> JSValue
	func restoreCursorPosition() -> JSValue
	func cursorPosition(_ rnum: JSValue, _ cnum: JSValue) -> JSValue
	func eraceFromCursorToEnd() -> JSValue
	func eraceFromCursorToBegin() -> JSValue
	func eraceEntireBuffer() -> JSValue
	func eraceFromCursorToRight() -> JSValue
	func eraceFromCursorToLeft() -> JSValue
	func eraceEntireLine() -> JSValue
	func scrollUp(_ cnt: JSValue) -> JSValue
	func scrollDown(_ cnt: JSValue) -> JSValue
	func resetAll() -> JSValue
	func resetCharacterAttribute() -> JSValue
	func boldCharacter(_ flg: JSValue) -> JSValue
	func underlineCharacter(_ flg: JSValue) -> JSValue
	func blinkCharacter(_ flg: JSValue) -> JSValue
	func reverseCharacter(_ flg: JSValue) -> JSValue
	func foregroundColor(_ col: JSValue) -> JSValue
	func defaultForegroundColor() -> JSValue
	func backgroundColor(_ col: JSValue) -> JSValue
	func defaultBackgroundColor() -> JSValue
	func requestScreenSize() -> JSValue
	func screenSize(_ wnum: JSValue, _ hnum: JSValue) -> JSValue
	func selectAltScreen(_ flg: JSValue) -> JSValue
	func setFontStyle(_ stl: JSValue) -> JSValue
	func setFontSize(_ sz: JSValue) -> JSValue
}

@objc public class KLEscapeSequences: NSObject, KLEscapeSequencesProtocol
{
	private var mContext:   KEContext
        private var mSequences: CNEscapeSequences

	public init(context ctxt: KEContext) {
		mContext   = ctxt
                mSequences = CNEscapeSequences()
	}

	public func string(_ str: JSValue) -> JSValue {
		if let s = valueToString(value: str) {
			let eseq = mSequences.str(string: s)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func eot() -> JSValue {
		let eseq = mSequences.eot()
		return sequenceToValue(sequence: eseq)
	}

	public func newline() -> JSValue {
		let eseq = mSequences.newline()
		return sequenceToValue(sequence: eseq)
	}

	public func tab() -> JSValue {
		let eseq = mSequences.tab()
		return sequenceToValue(sequence: eseq)
	}

	public func backspace() -> JSValue {
		let eseq = mSequences.backspace()
		return sequenceToValue(sequence: eseq)
	}

	public func delete() -> JSValue {
		let eseq = mSequences.delete()
		return sequenceToValue(sequence: eseq)
	}

	public func insertSpaces(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.insertSpaces(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorUp(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorUp(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorDown(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorDown(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorForward(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorForward(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorBackward(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorBackward(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorNextLine(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorNextLine(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorPreviousLine(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorPreviousLine(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorHolizontalAbsolute(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.cursorHolizontalAbsolute(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func cursorVisible(_ flg: JSValue) -> JSValue {
		if let flag = valueToBool(value: flg) {
			let eseq = mSequences.cursorVisible(flag: flag)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func saveCursorPosition() -> JSValue {
		let eseq = mSequences.saveCursorPosition()
		return sequenceToValue(sequence: eseq)
	}

	public func restoreCursorPosition() -> JSValue {
		let eseq = mSequences.restoreCursorPosition()
		return sequenceToValue(sequence: eseq)
	}

	public func cursorPosition(_ rnum: JSValue, _ cnum: JSValue) -> JSValue {
		if let r = valueToInt(value: rnum), let c = valueToInt(value: cnum) {
                        let eseq = mSequences.cursorPosition(row: r, column: c)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func eraceFromCursorToEnd() -> JSValue {
		let eseq = mSequences.eraceFromCursorToEnd()
		return sequenceToValue(sequence: eseq)
	}

	public func eraceFromCursorToBegin() -> JSValue {
		let eseq = mSequences.eraceFromCursorToBegin()
		return sequenceToValue(sequence: eseq)
	}

	public func eraceEntireBuffer() -> JSValue {
		let eseq = mSequences.eraceEntireBuffer()
		return sequenceToValue(sequence: eseq)
	}

	public func eraceFromCursorToRight() -> JSValue {
		let eseq = mSequences.eraceFromCursorToRight()
		return sequenceToValue(sequence: eseq)
	}

	public func eraceFromCursorToLeft() -> JSValue {
		let eseq = mSequences.eraceFromCursorToLeft()
		return sequenceToValue(sequence: eseq)
	}

	public func eraceEntireLine() -> JSValue {
		let eseq = mSequences.eraceEntireLine()
		return sequenceToValue(sequence: eseq)
	}

	public func scrollUp(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.scrollUp(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func scrollDown(_ cnt: JSValue) -> JSValue {
		if let count = valueToInt(value: cnt) {
			let eseq = mSequences.scrollDown(count: count)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func resetAll() -> JSValue {
		let eseq = mSequences.resetAll()
		return sequenceToValue(sequence: eseq)
	}

	public func resetCharacterAttribute() -> JSValue {
		let eseq = mSequences.resetCharacterAttribute()
		return sequenceToValue(sequence: eseq)
	}

	public func boldCharacter(_ flg: JSValue) -> JSValue {
		if let flag = valueToBool(value: flg) {
			let eseq = mSequences.boldCharacter(flag: flag)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func underlineCharacter(_ flg: JSValue) -> JSValue {
		if let flag = valueToBool(value: flg) {
			let eseq = mSequences.underlineCharacter(flag: flag)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func blinkCharacter(_ flg: JSValue) -> JSValue {
		if let flag = valueToBool(value: flg) {
			let eseq = mSequences.blinkCharacter(flag: flag)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func reverseCharacter(_ flg: JSValue) -> JSValue {
		if let flag = valueToBool(value: flg) {
			let eseq = mSequences.reverseCharacter(flag: flag)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func foregroundColor(_ col: JSValue) -> JSValue {
		if let color = valueToColor(value: col) {
			let eseq = mSequences.foregroundColor(color: color)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func defaultForegroundColor() -> JSValue {
		let eseq = mSequences.defaultForegroundColor()
		return sequenceToValue(sequence: eseq)
	}

	public func backgroundColor(_ col: JSValue) -> JSValue {
		if let color = valueToColor(value: col) {
			let eseq = mSequences.backgroundColor(color: color)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func defaultBackgroundColor() -> JSValue {
		let eseq = mSequences.defaultBackgroundColor()
		return sequenceToValue(sequence: eseq)
	}

	public func requestScreenSize() -> JSValue {
		let eseq = mSequences.requestScreenSize()
		return sequenceToValue(sequence: eseq)
	}

	public func screenSize(_ wnum: JSValue, _ hnum: JSValue) -> JSValue {
		if let w = valueToInt(value: wnum), let h = valueToInt(value: hnum) {
			let eseq = mSequences.screenSize(width: w, height: h)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func selectAltScreen(_ flg: JSValue) -> JSValue {
		if let flag = valueToBool(value: flg) {
			let eseq = mSequences.selectAltScreen(flag: flag)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func setFontStyle(_ stl: JSValue) -> JSValue {
		if let style = valueToInt(value: stl) {
			let eseq = mSequences.setFontStyle(style: style)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	public func setFontSize(_ sz: JSValue) -> JSValue {
		if let size = valueToInt(value: sz) {
			let eseq = mSequences.setFontSize(size: size)
			return sequenceToValue(sequence: eseq)
		} else {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
			return JSValue(nullIn: mContext)
		}
	}

	private func sequenceToValue(sequence seq: CNEscapeSequence) -> JSValue {
		let obj = KLEscapeSequence(escapeSequence: seq, context: mContext)
		return JSValue(object: obj, in: mContext)
	}

	private func valueToString(value val: JSValue) -> String? {
		if val.isString {
			return val.toString()
		} else {
			return nil
		}
	}

	private func valueToColor(value val: JSValue) -> CNColor? {
		if val.isObject {
			if let col = val.toColor() {
				return col
			} else {
				return nil
			}
		} else {
			return nil
		}
	}

	private func valueToInt(value val: JSValue) -> Int? {
		if let num = val.toNumber() {
			return num.intValue
		} else {
			return nil
		}
	}

	private func valueToBool(value val: JSValue) -> Bool? {
		if val.isBoolean {
			return val.toBool()
		} else {
			return nil
		}
	}
}
