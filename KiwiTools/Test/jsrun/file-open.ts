/**
 * @file file-open.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number
{
	let fileurl = URL("file-open.ts") ;
	if(fileurl == null){
		return -1 ;
	}
	let file = FileManager.open(fileurl, "r") ;
	if(file != null){
		let docont = true ;
		while(docont){
			let line = file.getl() ;
			if(line != null){
				stdout.put(line) ;
			} else {
				docont = false ;
			}
		}
		file.close() ;
		return 0 ;
	} else {
		console.error("Failed to open file\n") ;
		return -1 ;
	}
}

