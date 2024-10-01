/**
 * @file jsh.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/command.d.ts"/>

function main(argv: string[])
{
	let prompt = "% " ;
	let parser = new CommandLineParser() ;
	while(true){
		console.print(prompt) ;
		let line = readline() ;
		let cmd  = parser.parse(line) ;
		if(cmd != null){
			cmd.execute() ;
		}
	}
}

