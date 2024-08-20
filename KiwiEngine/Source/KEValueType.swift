/**
 * @file	KEEnum.swift
 * @brief	Extend CNEnum class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import Foundation

public extension CNValueType
{
	func toScript() -> CNTextSection? {
		let result: CNTextSection?
		switch self {
		case .voidType, .anyType, .boolType, .numberType, .stringType, .arrayType(_), .dictionaryType(_), .setType(_), .objectType(_), .functionType(_, _), .nullable(_):
			result = nil
		case .enumType(let etype):
			result = etype.toScript()
		case .interfaceType(_):
			result = nil
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			result = nil
		}
		return result
	}

	func toDeclaration(isInside inside: Bool) -> CNText {
		let result: CNText
		switch self {
		case .voidType:
			result = CNTextLine(string: "void")
		case .anyType:
			result = CNTextLine(string: "any")
		case .boolType:
			result = CNTextLine(string: "boolean")
		case .numberType:
			result = CNTextLine(string: "number")
		case .stringType:
			result = CNTextLine(string: "string")
		case .arrayType(let elmtype):
			let elmdecl = elementDeclaration(elementType: elmtype)
			result = CNTextLine(string: elmdecl + "[]")
		case .setType(let elmtype):
			let elmdecl = elementDeclaration(elementType: elmtype)
			result = CNTextLine(string: elmdecl + "[]")
		case .nullable(let elmtype):
			let elmdecl = elementDeclaration(elementType: elmtype)
			result = CNTextLine(string: elmdecl + " | null")
		case .dictionaryType(let elmtype):
			let elmdecl = elementDeclaration(elementType: elmtype)
			result = CNTextLine(string: "{[name: string]: \(elmdecl)}")
		case .enumType(let etype):
			result = etype.toDeclaration(isInside: inside)
		case .interfaceType(let iftype):
			result = iftype.toDeclaration(isInside: inside)
		case .functionType(let rettype, let paramtypes):
			result = functionDeclaration(returnType: rettype, parameterTypes: paramtypes)
		case .objectType(let clsname):
			result = CNTextLine(string: clsname ?? "Object")
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown case", atFunction: #function, inFile: #file)
			result = CNTextLine(string: "void")
		}
		return result
	}

	private func elementDeclaration(elementType elmtype: CNValueType) -> String {
		return elmtype.toDeclaration(isInside: true).toStrings().joined(separator: "\n")
	}

	private func functionDeclaration(returnType rettype: CNValueType, parameterTypes paramtypes: Array<CNValueType>) -> CNTextLine {
		let retdecl   = rettype.toDeclaration(isInside: true).toStrings().joined(separator: "\n")
		var paramdecl  = ""
		var is1stparam = true
		var paramid    = 0
		for ptype in paramtypes {
			if !is1stparam { paramdecl += ", " }
			let pdecl   = ptype.toDeclaration(isInside: true).toStrings().joined(separator: "\n")
			paramdecl += "p\(paramid) : " + pdecl
			is1stparam = false
			paramid += 1
		}
		let line = "(" + paramdecl + ") => " + retdecl
		return CNTextLine(string: line)
	}
}

public extension CNEnumType
{
	func toScript() -> CNTextSection {
		let result: CNTextSection = CNTextSection()

		/* Member definition */
		let defsect = CNTextSection()
		defsect.header = "const \(self.typeName) = {"
		defsect.footer = "} ;"
		result.add(text: defsect)

		let list = CNTextList()
		list.separator = ","
		for name in self.names {
			if let value = self.value(forMember: name) {
				let line = CNTextLine(string: "\(name): \(value.toScript())")
				list.add(text: line)
			} else {
				CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
			}
		}
		defsect.add(text: list)

		/* static method definition */
		/* "description" function */
		if self.value(forMember: "description") == nil {
			let descfunc = CNTextSection()
			descfunc.header = "description: function(val) {"
			descfunc.footer = "}"

			let switchfunc = CNTextSection()
			switchfunc.header = "let result = \"?\" ; switch(val){"
			switchfunc.footer = "} ; return result ;"
			for name in self.names {
				if let value = self.value(forMember: name) {
					let stmt = "   case \(value.toScript()): result=\"\(name)\" ; break ;"
					switchfunc.add(text: CNTextLine(string: stmt))
				} else {
					CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
				}
			}
			descfunc.add(text: switchfunc)
			list.add(text: descfunc)
		}

		/* "keys" variable */
		if self.value(forMember: "keys") == nil {
			let keys     = self.names.map{ "\"" + $0 + "\"" }
			let keystr   = keys.joined(separator: ", ")
			let keysline = CNTextLine(string: "keys: [\(keystr)]")
			list.add(text: keysline)
		}
		//let dump = defsect.toStrings().joined(separator: "\n")
		//NSLog("enum = " + dump)
		return result
	}

	func toDeclaration(isInside inside: Bool) -> CNText {
		if inside {
			return CNTextLine(string: self.typeName)
		} else {
			let result: CNTextSection = CNTextSection()

			/* Member definition */
			let sect = CNTextSection()
			sect.header = "declare enum \(self.typeName) {"
			sect.footer = "}"

			let list = CNTextList()
			list.separator = ","
			for name in self.names {
				if let value = self.value(forMember: name) {
					let line = CNTextLine(string: "\(name) = \(value.toScript())")
					list.add(text: line)
				} else {
					CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
				}
			}
			sect.add(text: list)
			result.add(text: sect)

			return result
		}
	}
}

public extension CNInterfaceType
{
	func toDeclaration(isInside inside: Bool) -> CNText {
		if inside {
			return CNTextLine(string: self.name)
		} else {
			/* get base type */
			let extend: String
			if let base = self.base {
				extend = "extends \(base.name) "
			} else {
				extend = ""
			}
			let result: CNTextSection = CNTextSection()
			result.header = "interface \(self.name) \(extend){"
			result.footer = "}"

			for member in self.members {
				switch member.type {
				case .functionType(let rettype, let paramtypes):
					let decltxt = functionToDeclaration(name: member.name, returnType: rettype, parameterTypes: paramtypes)
					let declstr = decltxt.toStrings().joined(separator: "\n")
					let declline = CNTextLine(string: declstr + " ;")
					result.add(text: declline)
				default:
					let decltxt = member.type.toDeclaration(isInside: true)
					let declstr = decltxt.toStrings().joined(separator: "\n")
					let declline = CNTextLine(string: "\(member.name) : \(declstr) ;")
					result.add(text: declline)
				}
			}
			return result
		}
	}

	private func functionToDeclaration(name nm: String, returnType rettype: CNValueType, parameterTypes ptypes: Array<CNValueType>) -> CNText {
		let retdecl   = rettype.toDeclaration(isInside: true).toStrings().joined(separator: "\n")
		var paramdecl  = ""
		var is1stparam = true
		var paramid    = 0
		for ptype in ptypes {
			if !is1stparam { paramdecl += ", " }
			let pdecl   = ptype.toDeclaration(isInside: true).toStrings().joined(separator: "\n")
			paramdecl += "p\(paramid) : " + pdecl
			is1stparam = false
			paramid += 1
		}
		let line = nm + "(" + paramdecl + "): " + retdecl
		return CNTextLine(string: line)
	}
}

