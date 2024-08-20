/**
 * @file	KHExecutor.swift
 * @brief	Define KHExecutorl class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

public class KHExecutor
{
	private var mContext:	KEContext
	private var mConsole:	CNFileConsole

	public init(context ctxt: KEContext, console cons: CNFileConsole) {
		self.mContext = ctxt
		self.mConsole = cons
	}

	public func exec(lines lns: Array<String>) {
		let mlines  = CNLineConnector.connectLines(lines: lns)
		let aline   = mlines.joined(separator: "\n") + "\n"
		exec(line: aline)
	}

	public func exec(line ln: String) {
		/* this is not command. treat as the JavaScript code */
		if let retval = mContext.evaluateScript(ln) {
			if let str = returnValue(value: retval) {
				mConsole.print(string: str + "\n")
			}
		}
	}

	private func returnValue(value val: JSValue) -> String? {
		guard !val.isNull && !val.isUndefined else {
			return nil
		}
		if val.isBoolean {
			return val.toBool() ? "true" : "false"
		} else if let str = val.toString() {
			return str
		} else {
			return nil
		}
	}
}

