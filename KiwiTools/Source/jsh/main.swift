/**
 * @file	main.swift
 * @brief	Define main function for jsh command
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiShell
import Foundation

func main(arguments args: Array<String>)
{
	let console = CNFileConsole()
	if let infile = console.inputFile as? CNInputFile {
		infile.setRawMode(enable: true)
	}

	let shell   = KHShell(application: .terminal, console: console)
	shell.execute()
}

main(arguments: CommandLine.arguments)


