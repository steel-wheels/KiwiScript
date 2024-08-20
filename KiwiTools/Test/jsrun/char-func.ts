/**
 * @file char-func.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number {
	test("a") ;
	test("3") ;
	test("_") ;
	test("-") ;
	test(" ") ;
	test("ident0") ;
	test("ident0-ident1") ;
	return 0 ;
}

function test(str: string){
	print(str, "isIdentifier", isIdentifier(str)) ;
}

function print(str: string, funcname: string, result: boolean)
{
	console.print(funcname + "(\"" + str + "\") -> "
	  + (result ? "true" : "false") + "\n") ;
}

