/**
 * Builtin.d.ts
 */

/* Singleton object*/
declare var console:		ConsoleIF ;
declare var Colors:      	ColorsIF ;
declare var Curses:     	CursesIF ;
declare var FileManagerCore:	FileManagerIF ;
declare var TerminalController:	EscapeCodesIF ;
declare var EscapeSequences:	EscapeSequencesIF ;

declare var env:		EnvironmentIF ;


declare function Point(x: number, y: number): PointIF ;
declare function Rect(x: number, y: number, width: number, height: number): RectIF ;
declare function Oval(x: number, y: number, radius:number): OvalIF ;
declare function Vector(dx: number, dy: number): VectorIF ;
declare function Size(width: number, height: number): SizeIF ;
declare function URL(path: string): URLIF | null ;

declare function StringStream(str: string): StringStreamIF ;

declare function toArray(value: any): any[] | null ;
declare function toBitmap(value: any): BitmapContextIF | null ;
declare function toBoolean(value: any): boolean | null ;
declare function toDate(value: any): object | null ;
declare function toNumber(value: any): number | null ;
declare function toDictionary(value: any): {[name:string]: any} | null ;
declare function toRecord(value: any): RecordIF | null ;
declare function toObject(value: any): object | null ;
declare function toPoint(value: any): PointIF | null ;
declare function toRect(value: any): RectIF | null ;
declare function toOval(value: any): OvalIF | null ;
declare function toVector(value: any): VectorIF | null ;
declare function toSize(value: any): SizeIF | null ;
declare function toString(value: any): string | null ;
declare function toURL(value: any): URLIF | null ;

declare function asciiCodeName(code: number): string | null ;

declare function _openURL(title: URLIF | string, cbfunc: any): void ;

declare function tokenize(str: string): TokenIF[] | null ;

