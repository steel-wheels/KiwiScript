/**
 * @file	KLExitCode.swift
 * @brief	Define KLErrorCode type
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

public extension CNExitCode
{
	static func fromValue(value val: JSValue) -> CNExitCode {
		if let num = val.toNumber() {
			if let ecode = CNExitCode(rawValue: num.intValue) {
				return ecode
			}
		}
		return .internalError
	}
}
