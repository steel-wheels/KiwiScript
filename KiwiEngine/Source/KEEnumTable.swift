/**
 * @file	KEEnumTable.swift
 * @brief	Define KEEnumTable class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData

/*
public extension CNEnumTable
{
	/*
	 * // member definition
	 * const Position = {
	 *  Top: 0,
	 *  Right: 1,
	 *  Bottom: 2,
	 *  Left: 3,
	 * } ;
	 */
	func toScript() -> CNTextSection {
		let result: CNTextSection = CNTextSection()
		guard self.count > 0 else {
			return result
		}
		let enames = self.allTypes.keys.sorted()
		for ename in enames {
			if let etype = self.search(byTypeName: ename) {
				let txt = etype.toScript()
				result.add(text: txt)
			} else {
				CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
			}
		}
		return result
	}

	func toDeclaration() -> CNTextSection {
		let result: CNTextSection = CNTextSection()
		guard self.count > 0 else {
			return result
		}
		let enames = self.allTypes.keys.sorted()
		for ename in enames {
			if let etype = self.search(byTypeName: ename) {
				let txt = etype.toDeclaration(isInside: false)
				result.add(text: txt)
			} else {
				CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
			}
		}
		return result
	}
}
*/

