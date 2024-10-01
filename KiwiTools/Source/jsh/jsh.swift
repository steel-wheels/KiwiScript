/**
 * @file	jsh.swift
 * @brief	Define main function for jsh command
 * @par Copyright
 *   Copyright (C) 2023-2024 Steel Wheels Project
 */

import CoconutData
import KiwiShell
import Foundation

@main struct AppBoxCLI {
        static func main() async throws {
                jsh(arguments: CommandLine.arguments)
        }
}

func jsh(arguments args: Array<String>)
{
	let console = CNFileConsole()
	if let infile = console.inputFile as? CNInputFile {
		infile.setRawMode(enable: true)
	}

	let shell   = KHShell(application: .terminal, console: console)
	shell.execute()
}



