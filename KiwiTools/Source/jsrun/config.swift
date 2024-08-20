/**
 * @file	config..swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Cobalt
import Foundation

private let ApplicationName = "jsrun"

public class Config
{
	private var mFileName:  	String
	private var mScriptArguments:	Array<String>

	public var fileName:		String        { get { return mFileName  }}
	public var scriptArguments:	Array<String> { get { return mScriptArguments }}

	public init(fileName name: String, scriptArguments args: Array<String>){
		mFileName		= name
		mScriptArguments	= args
	}

	public func dump(console cons: CNConsole){
		let message =     "Config {\n"
				+ "  filename: \(self.fileName)\n"
				+ "  scriptArguments: \(self.scriptArguments)\n"
				+ "}\n"
		cons.print(string: message)
	}

}


public class CommandLineParser
{
	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
	}

	private var mConsole:	CNConsole

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func printUsage() {
		mConsole.print(string: "usage: \(ApplicationName) [options] filename (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: \(ApplicationName) [options] filename [arguments]\n" +
		"  [options]\n" +
		"    --help, -h         : Print this message\n" +
		"    --version          : Print version\n" +
		"  [filename]\n" +
		"    file-name          : source file or source package (*.js or *.jspkg/)" +
		"  [arguments]\n" +
		"                       : arguments to be passed to the script\n"
		)
	}

	public func parseArguments(arguments args: Array<String>) -> Config? {
		var cmdargs: Array<String> = []		// Arguments for this command
		var scrargs: Array<String> = []		// Arguments to be passed to the script
		var filename: String       = ""
		var idx: Int		   = 0

		/* Get options and filename for this command (skipt script name) */
		for i in 0..<args.count {
			idx = i
			if isCommandOption(string: args[i]) {
				cmdargs.append(args[i])
			} else {
				filename = args[i]
				break
			}
		}

		/* Other arguments are passed to the script */
		if idx+1 < args.count {
			for i in idx+1..<args.count {
				scrargs.append(args[i])
			}
		}

		return decodeConfig(fileName: filename, commandArguments: cmdargs, scriptArguments: scrargs)
	}

	private func isCommandOption(string str: String) -> Bool {
		if let c = str.first {
			if(c == "-") {
				return true
			}
		}
		return false
	}

	private func decodeConfig(fileName fname: String, commandArguments cmdargs: Array<String>, scriptArguments scrargs: Array<String>) -> Config? {
		let (err, _, rets, _) = CBParseArguments(parserConfig: parserConfig(), arguments: cmdargs)
		if let e = err {
			mConsole.error(string: "[Error] \(e.description)\n")
			return nil
		}
		/* Decode command line options */
		let stream = CNArrayStream(source: rets)
		while let arg = stream.get() {
			if let opt = arg as? CBOptionArgument {
				if let optid = OptionId(rawValue: opt.optionType.optionId) {
					switch optid {
					case .Help:
						printHelpMessage()
						return nil
					case .Version:
						printVersionMessage()
						return nil
					}
				} else {
					mConsole.error(string: "[Error] Unknown command line option id")
				}
			} else {
				mConsole.error(string: "[Error] Unknown command line parameter: \(arg)")
				return nil
			}
		}
		return Config(fileName: fname, scriptArguments: scrargs)
	}

	private func parserConfig() -> CBParserConfig {
		let opttypes: Array<CBOptionType> = [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: OptionId.Version.rawValue,
				     shortName: "v", longName: "version",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Print version information"),
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func printVersionMessage() {
		let plist   = CNPropertyList.load(bundleName: "ArisiaTools.bundle")
                let version = plist.versionString
		mConsole.print(string: "jsh \(version)\n")
	}
}
