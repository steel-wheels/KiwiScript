/**
 * @file	KEConfig.swift
 * @brief	Extend KEConfig class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import CoconutData
import Foundation

open class KEConfig: CNConfig
{
	private var	mApplicationType:	CNApplicationType
	public var	mDoStrict:		Bool

	public var applicationType: 	CNApplicationType	{ get { return mApplicationType }}
	public var doStrict:		Bool			{ get { return mDoStrict	}}

	public init(applicationType atype: CNApplicationType, doStrict strict: Bool, logLevel log: CNConfig.LogLevel) {
		mApplicationType	= atype
		mDoStrict  		= strict
		super.init(logLevel: log)
	}
}

