/**
 * @file	properties..swift
 * @brief	Extend CNValueProperties
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import KiwiLibrary
import Foundation

public extension CNValuePropertiesType
{
	func toTypeDeclaration(typePrefix prefix: String) -> CNText {
		let result = CNTextSection()
		result.header = "\(prefix)_PropertiesIF extends PropertiesIF {"
		result.footer = "}"
		for (key, type) in self.properties {
			let typestr = CNValueType.convertToTypeDeclaration(valueType: type)
			let line    = CNTextLine(string: key + " : " + typestr)
			result.add(text: line)
		}
		return result
	}
}

