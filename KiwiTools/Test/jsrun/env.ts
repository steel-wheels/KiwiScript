/**
 * @file env.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[])
{
	let url = env.currentDirectory ;
	console.print("current-directory: " + url.path + "\n") ;

	let packurl = env.packageDirectory ;
	console.print("package-directory: " + packurl.path + "\n") ;

	let home = env.getVariable("HOME") ;
	if(home != null){
	    console.print("env[HOME]: " + home + "\n") ;
	} else {
	    console.print("env[HOME]: " + "null" + "\n") ;
	}

	return 0 ;
}

