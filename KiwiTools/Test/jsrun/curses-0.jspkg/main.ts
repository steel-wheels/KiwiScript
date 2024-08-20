/*
 * main.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number
{
	Curses.begin() ;
	Curses.foregroundColor = Colors.yellow ;
	Curses.backgroundColor = Colors.blue ;

	console.print("Hello, world !!\n") ;
	sleep(2) ;

	Curses.end() ;
	return 0 ;
}

