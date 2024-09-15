/**
 * Builtin.d.ts
 */

declare var EscapeSequences:   EscapeSequencesIF
declare function StringStream(str: string): StringStreamIF ;
declare var TerminalController:        EscapeCodesIF ;

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

interface ReadlineCoreIF {
	execute(): string | null ;
}
declare var _readlineCore:	ReadlineCoreIF

