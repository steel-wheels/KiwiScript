/**
 * @file graph-type.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number
{
	let pt = Point(2.0, 3.0) ;
	console.print("isPoint = " + isPoint(pt) + "\n") ;

	let rect = Rect(0, 0, 10.0, 11.0) ;
	console.print("isRect = " + isRect(rect) + "\n") ;

	let oval = Oval(0.0, 0.0, 14.0) ;
	console.print("isOval = " + isOval(oval) + "\n") ;

	let vec = Vector(1.1, 2.2) ;
	console.print("vec    = " + vec    + "\n") ;
	console.print("vec.dx = " + vec.dx + "\n") ;
	console.print("vec.dy = " + vec.dy + "\n") ;
	console.print("isVector = " + isVector(vec) + "\n") ;

	let size = Size(5, 6) ;
	console.print("isSize = " + isSize(size) + "\n") ;

	return 0 ;
}

