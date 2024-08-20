/**
 * @file type.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number {
	test("abc") ;
	test(" \t ") ;
	test("a_0B") ;
	test("123") ;
	return 0 ;
}

function test(str: string){
	print(str, "isSpace", isSpace(str)) ;
	print(str, "isNumber", isNumber(str)) ;
	print(str, "isAlphaNumetics", isAlphaNumerics(str)) ;
	print(str, "isIdentifier", isIdentifier(str)) ;
}

function print(str: string, funcname: string, result: boolean)
{
	console.print(funcname + "(\"" + str + "\") -> "
	  + (result ? "true" : "false") + "\n") ;
}

