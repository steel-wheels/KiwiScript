/**
 * @file	edecl..swift
 * @brief	Define main function for edecl command
 * @par Copyright
 *   Copyright (C) 2022-2024 Steel Wheels Project
 */

import CoconutData
import Foundation

@main struct AppBoxCLI {
        static func main() async throws {
                edecl(arguments: CommandLine.arguments)
        }
}

func edecl(arguments args: Array<String>)
{
	let console = CNFileConsole()
	let cmdline = CommandLineParser(console: console)
	guard let (_, _) = cmdline.parseArguments(arguments: Array(args.dropFirst())) else {
		return
	}

	/* Dump all default types */
	let vmgr  = CNValueTypeManager.shared
	let names = vmgr.typeNames
	for name in names {
		if let vtype = vmgr.search(byName: name) {
			let decl   = vtype.toDeclaration(isInside: false)
			let outurl = URL(fileURLWithPath: "\(vtype.typeName)-\(name).d.ts")
			let str    = decl.toStrings().joined(separator: "\n")
			if !outurl.save(string: str + "\n") {
				console.print(string: "[Error] Failed to make output file: \(outurl.path)\n")
			}
		}
	}

	/* Dump all interface types */
	//for (ifname, iftype) in CNInterfaceTable.currentInterfaceTable().allTypes {
	//	generateInterfaceDeclaration(interfaceName: ifname, interfaceType: iftype, console: console, config: config)
	//}
}





