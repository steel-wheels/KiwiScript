/*
 * main.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number
{
	let sym0: Symbols = Symbols.character ;
	console.print("symbol.name = " + sym0 + "\n") ;

	let sym1: Symbols  = Symbols.terminal ;
	console.print("symbol.name = " + sym1 + "\n") ;

	return 0 ;
}

