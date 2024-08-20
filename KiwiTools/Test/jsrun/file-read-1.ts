/**
 * @file file-read.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number
{
	let docont: boolean = true ;
	while(docont){
		let line = stdin.getl() ;
		if(line != null){
			console.print(line) ;
		} else {
			docont = false ;
		}
	}
	return 0 ;
}

