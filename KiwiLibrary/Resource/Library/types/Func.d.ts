declare function exit(code: number): void ;

declare function isAlphaNumerics(str: string): boolean ;

declare function isArray(value: any): boolean ;
declare function isBitmap(value: any): boolean ;
declare function isBoolean(value: any): boolean ;
declare function isDate(value: any): boolean ;
declare function isDictionary(value: any): boolean ;
declare function isEOF(str: string): boolean ;
declare function isIdentifier(str: string): boolean ;
declare function isNull(value: any | null): boolean ;
declare function isNumber(value: any): boolean ;
declare function isObject(value: any): boolean ;
declare function isOval(value: any): boolean ;
declare function isPoint(value: any): boolean ;
declare function isRecord(value: any): boolean ;
declare function isRect(value: any): boolean ;
declare function isSize(value: any): boolean ;
declare function isSpace(str: string): boolean ;
declare function isString(value: any): boolean ;
declare function isUndefined(value: any): boolean ;
declare function isURL(value: any): boolean ;
declare function isVector(value: any): boolean ;

declare function sleep(sec: number): boolean ;

declare function Icon(tag: number, symbol: Symbols, label: String): IconIF ;

declare function MenuItem(title: string, value: number): MenuItemIF ;

declare function Oval(x: number, y: number, radius:number): OvalIF ;
declare function Pipe(): PipeIF ;

declare function Point(x: number, y: number): PointIF ;
declare function Properties(name: string): PropertiesIF | null ;
declare function Rect(x: number, y: number, width: number, height: number): RectIF ;
declare function Size(width: number, height: number): SizeIF ;
declare function SpriteActions(): SpriteActionsIF ;

declare function Table(name: string): TableIF | null ;

declare function _Thread(path: string, console: ConsoleIF): ThreadIF | null ;

declare function URL(path: string): URLIF | null ;
declare function Vector(dx: number, dy: number): VectorIF ;
