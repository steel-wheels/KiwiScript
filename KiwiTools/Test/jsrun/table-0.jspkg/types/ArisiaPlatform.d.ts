declare enum AccessType {
  append = 2,
  read = 0,
  write = 1
}
declare enum AlertType {
  critical = 3,
  informational = 1,
  warning = 2
}
declare enum Alignment {
  center = 3,
  fill = 2,
  leading = 0,
  trailing = 1
}
declare enum AnimationState {
  idle = 0,
  pause = 2,
  run = 1
}
declare enum Authorize {
  authorized = 3,
  denied = 2,
  undetermined = 0
}
declare enum Axis {
  horizontal = 0,
  vertical = 1
}
declare enum ButtonState {
  disable = 1,
  hidden = 0,
  off = 2,
  on = 3
}
declare enum ComparisonResult {
  ascending = -1,
  descending = 1,
  same = 0
}
declare enum Device {
  carPlay = 4,
  ipad = 2,
  mac = 0,
  phone = 1,
  tv = 3
}
declare enum Distribution {
  equalSpacing = 3,
  fill = 0,
  fillEqually = 2,
  fillProportinally = 1
}
declare enum ExitCode {
  commaneLineError = 2,
  exception = 6,
  fileError = 3,
  internalError = 1,
  noError = 0,
  runtimeError = 5,
  syntaxError = 4
}
declare enum FileType {
  directory = 2,
  file = 1,
  notExist = 0
}
declare enum FontSize {
  large = 2,
  regular = 1,
  small = 0
}
declare enum FontStyle {
  monospace = 1,
  normal = 0
}
declare enum Language {
  chinese = 0,
  deutch = 1,
  english = 2,
  french = 3,
  italian = 4,
  japanese = 5,
  korean = 6,
  others = 9,
  russian = 7,
  spanish = 8
}
declare enum LogLevel {
  debug = 3,
  detail = 4,
  error = 1,
  nolog = 0,
  warning = 2
}
declare enum ProcessStatus {
  cancelled = 3,
  finished = 2,
  idle = 0,
  running = 1
}
declare enum SortOrder {
  decreasing = 1,
  increasing = -1,
  none = 0
}
declare enum SpriteMaterial {
  image = 3,
  text = 2
}
declare enum SymbolSize {
  large = 180,
  regular = 120,
  small = 60
}
declare enum Symbols {
  character = "character",
  checkmarkSquare = "checkmark.square",
  chevronBackward = "chevron.backward",
  chevronDown = "chevron.down",
  chevronForward = "chevron.forward",
  chevronUp = "chevron.up",
  gamecontroller = "gamecontroller",
  gearshape = "gearshape",
  handPointUp = "hand.point.up",
  handRaised = "hand.raised",
  house = "house",
  line16p = "line.16p",
  line1p = "line.1p",
  line2p = "line.2p",
  line4p = "line.4p",
  line8p = "line.8p",
  lineDiagonal = "line.diagonal",
  moonStars = "moon.stars",
  oval = "oval",
  ovalFill = "oval.fill",
  paintbrush = "paintbrush",
  pencil = "pencil",
  pencilCircle = "pencil.circle",
  pencilCircleFill = "pencil.circle.fill",
  play = "play",
  questionmark = "questionmark",
  rectangle = "rectangle",
  rectangleFill = "rectangle.fill",
  square = "square",
  sunMax = "sun.max",
  sunMin = "sun.min",
  terminal = "apple.terminal"
}
declare enum TokenType {
  bool = 3,
  float = 5,
  identifier = 2,
  int = 4,
  reservedWord = 0,
  symbol = 1,
  text = 6
}
interface FrameCoreIF {
  _value(p0: string): any ;
  _setValue(p0: string, p1: any): boolean ;
  _definePropertyType(p0: string, p1: string): void ;
  _addObserver(p0: string, p1: () => void): void ;
}

interface FrameIF extends FrameCoreIF {
  frameName: string ;
  propertyNames: string[] ;
}

interface EnvironmentIF {
  getVariable(p0 : string): string | null ;
  setVariable(p0 : string, p1 : string): void ;
  getAll(): {[name: string]: string} ;
  packageDirectory : URLIF ;
  currentDirectory : URLIF ;
}
interface CharIF {
  etx : string ;
  eot : string ;
  bel : string ;
  bs : string ;
  tab : string ;
  lf : string ;
  vt : string ;
  cr : string ;
  esc : string ;
  del : string ;
}
interface ColorIF {
  r : number ;
  g : number ;
  b : number ;
  a : number ;
}
interface ColorsIF {
  black : ColorIF ;
  red : ColorIF ;
  green : ColorIF ;
  yellow : ColorIF ;
  blue : ColorIF ;
  magenta : ColorIF ;
  cyan : ColorIF ;
  white : ColorIF ;
}
interface ConsoleIF {
  print(p0 : string): void ;
  error(p0 : string): void ;
  log(p0 : string): void ;
  scan(): string | null ;
}
interface DateIF {
  toString(): string ;
  year : number ;
  month : number ;
  day : number ;
}
interface FileIF {
  getc(): string | null ;
  getl(): string | null ;
  put(p0 : string): void ;
  close(): void ;
}
interface FileManagerIF {
  open(p0 : URLIF, p1 : string): FileIF | null ;
  fileExists(p0 : URLIF): boolean ;
  isReadable(p0 : URLIF): boolean ;
  isWritable(p0 : URLIF): boolean ;
  isExecutable(p0 : URLIF): boolean ;
  isAccessible(p0 : URLIF): boolean ;
  documentDirectory : URLIF ;
  libraryDirectory : URLIF ;
  applicationSupportDirectory : URLIF ;
  resourceDirectory : URLIF ;
  temporaryDirectory : URLIF ;
  currentDirectory : URLIF ;
  copy(p0 : URLIF, p1 : URLIF): boolean ;
  remove(p0 : URLIF): boolean ;
}
interface ImageIF extends FrameIF {
  size(): string ;
}
interface MenuItemIF {
  title : string ;
  value : number ;
}
interface OvalIF {
  center : PointIF ;
  radius : number ;
}
interface PipeIF {
  fileForReading : FileIF ;
  fileorWriting : FileIF ;
}
interface PointIF {
  x : number ;
  y : number ;
}
interface SizeIF {
  width : number ;
  height : number ;
}
interface TokenIF {
  type : TokenType ;
  lineNo : number ;
  original : string ;
  reservedWord(): number | null ;
  symbol(): string | null ;
  identifier(): string | null ;
  bool(): boolean | null ;
  int(): number | null ;
  float(): number | null ;
  text(): string | null ;
}
interface SymbolIF {
  name : string ;
}
interface URLIF {
  isNull : boolean ;
  absoluteStriung : string ;
  path : string ;
  appending(p0 : string): URLIF ;
  lastPathComponent : string ;
  deletingLastPathComponent : URLIF ;
  loadText(): string | null ;
}
interface RecordIF {
  fieldCount : number ;
  fieldNames : string[] ;
  setValue(p0 : any, p1 : string): void ;
  value(p0 : string): any | null ;
}
interface RectIF {
  x : number ;
  y : number ;
  width : number ;
  height : number ;
}
interface GraphicsContextIF {
  logicalFrame : RectIF ;
  setFillColor(p0 : ColorIF): void ;
  setStrrokeColor(p0 : ColorIF): void ;
  setPenSize(p0 : number): void ;
  moveTo(p0 : number, p1 : number): void ;
  lineTo(p0 : number, p1 : number): void ;
  rect(p0 : number, p1 : number, p2 : number, p3 : number, p4 : boolean): void ;
  circle(p0 : number, p1 : number, p2 : number, p3 : boolean): void ;
}
interface BitmapContextIF {
  width : number ;
  wheight : number ;
  get(p0 : number, p1 : number): ColorIF ;
  set(p0 : number, p1 : number, p2 : ColorIF): void ;
}
interface TriggerIF {
  trigger(): void ;
  isRunning(): boolean ;
  ack(): void ;
}
interface SpriteNodeRefIF {
  material : SpriteMaterial ;
  identifier : string ;
  nodeId : number ;
  position : PointIF ;
}
interface SpriteFieldIF {
  size : SizeIF ;
  nodes : SpriteNodeRefIF[] ;
}
interface SpriteNodeDeclIF {
  material : SpriteMaterial ;
  value : string ;
  script : string ;
  count : number ;
}
interface SpriteActionsIF {
  clear(): void ;
  setPosition(p0 : PointIF): void ;
  setVelocity(p0 : VectorIF): void ;
}
interface SpriteNodeIF {
  material : SpriteMaterial ;
  nodeId : number ;
  identifier : string ;
  currentTime : number ;
  trigger : TriggerIF ;
  position : PointIF ;
  size : SizeIF ;
  velocity : VectorIF ;
  mass : number ;
  density : number ;
  area : number ;
  actions : SpriteActionsIF ;
}
interface SpriteSceneIF {
  currentTime : number ;
  size : SizeIF ;
  trigger : TriggerIF ;
  field : SpriteFieldIF ;
}
interface ProcessIF {
  isRunning : boolean ;
  didFinished : boolean ;
  exitCode : number ;
  terminate(): void ;
}
interface RangeIF {
  location : number ;
  length : number ;
}
interface StringStreamIF {
  getc(): string | null ;
  gets(p0 : number): string | null ;
  getl(): string | null ;
  getident(): string | null ;
  getword(): string | null ;
  getint(): number | null ;
  ungetc(): string | null ;
  reqc(p0 : string): boolean ;
  peek(p0 : number): string | null ;
  skip(p0 : number): void ;
  skipSpaces(): void ;
  eof(): boolean ;
}
interface PropertiesIF {
  count : number ;
  names : string[] ;
  value(p0 : string): any ;
  set(p0 : any, p1 : string): boolean ;
}
interface TableIF {
  recordCount : number ;
  fieldName(p0 : number): string ;
  fieldNames(): string[] ;
  select(p0 : any, p1 : string): boolean ;
  remove(p0 : number): boolean ;
}
interface ThreadIF {
  start(p0 : string[]): number ;
  status : ProcessStatus ;
  exitCode : number ;
}
interface EscapeSequenceIF {
  toString(): string ;
}
interface EscapeSequencesIF {
  string(p0 : string): EscapeSequenceIF ;
  eot(): EscapeSequenceIF ;
  newline(): EscapeSequenceIF ;
  tab(): EscapeSequenceIF ;
  backspace(): EscapeSequenceIF ;
  delete(): EscapeSequenceIF ;
  insertSpaces(p0 : number): EscapeSequenceIF ;
  cursorUp(p0 : number): EscapeSequenceIF ;
  cursorDown(p0 : number): EscapeSequenceIF ;
  cursorForward(p0 : number): EscapeSequenceIF ;
  cursorBackward(p0 : number): EscapeSequenceIF ;
  cursorNextLine(p0 : number): EscapeSequenceIF ;
  cursorPreviousLine(p0 : number): EscapeSequenceIF ;
  cursorHolizontalAbsolute(p0 : number): EscapeSequenceIF ;
  cursorVisible(p0 : boolean): EscapeSequenceIF ;
  saveCursorPosition(): EscapeSequenceIF ;
  restoreCursorPosition(): EscapeSequenceIF ;
  cursorPosition(p0 : number, p1 : number): EscapeSequenceIF ;
  eraceFromCursorToEnd(): EscapeSequenceIF ;
  eraceFromCursorToBegin(): EscapeSequenceIF ;
  eraceEntireBuffer(): EscapeSequenceIF ;
  eraceFromCursorToRight(): EscapeSequenceIF ;
  eraceFromCursorToLeft(): EscapeSequenceIF ;
  eraceEntireLine(): EscapeSequenceIF ;
  scrollUp(p0 : number): EscapeSequenceIF ;
  scrollDown(p0 : number): EscapeSequenceIF ;
  resetAll(): EscapeSequenceIF ;
  resetCharacterAttribute(): EscapeSequenceIF ;
  boldCharacter(p0 : boolean): EscapeSequenceIF ;
  underlineCharacter(p0 : boolean): EscapeSequenceIF ;
  blinkCharacter(p0 : boolean): EscapeSequenceIF ;
  reverseCharacter(p0 : boolean): EscapeSequenceIF ;
  foregroundColor(p0 : ColorIF): EscapeSequenceIF ;
  defaultForegroundColor(): EscapeSequenceIF ;
  backgroundColor(p0 : ColorIF): EscapeSequenceIF ;
  defaultBackgroundColor(): EscapeSequenceIF ;
  requestScreenSize(): EscapeSequenceIF ;
  screenSize(p0 : number, p1 : number): EscapeSequenceIF ;
  selectAltScreen(p0 : boolean): EscapeSequenceIF ;
  setFontStyle(p0 : number): EscapeSequenceIF ;
  setFontSize(p0 : number): EscapeSequenceIF ;
}
interface EscapeCodesIF {
  execute(): any | null ;
  string(p0 : string): void ;
  newline(): void ;
  tab(): void ;
  backspace(): void ;
  delete(): void ;
  insertSpace(p0 : number): void ;
  cursorUp(p0 : number): void ;
  cursorDown(p0 : number): void ;
  cursorForward(p0 : number): void ;
  cursorBackward(p0 : number): void ;
  cursorNextLine(p0 : number): void ;
  cursorPreviousLine(p0 : number): void ;
  cursorHolizontalAbsolute(p0 : number): void ;
  cursorVisible(p0 : boolean): void ;
  saveCursorPosition(): void ;
  restoreCursorPosition(): void ;
  cursorPosition(p0 : number, p1 : number): void ;
  eraceFromCursorToEnd(): void ;
  eraceFromCursorToBegin(): void ;
  eraceEntireBuffer(): void ;
  eraceFromCursorToRight(): void ;
  eraceFromCursorToLeft(): void ;
  eraceEntireLine(): void ;
  scrollUp(p0 : number): void ;
  scrollDown(p0 : number): void ;
  resetAll(): void ;
  resetCharacterAttribute(): void ;
  boldCharacter(p0 : boolean): void ;
  underlineCharacter(p0 : boolean): void ;
  blinkCharacter(p0 : boolean): void ;
  reverseCharacter(p0 : boolean): void ;
  foregroundColor(p0 : ColorIF): void ;
  defaultForegroundColor(): void ;
  backgroundColor(p0 : ColorIF): void ;
  defaultBackgroundColor(): void ;
  requestScreenSize(): void ;
  screenSize(p0 : number, p1 : number): void ;
  selectAltScreen(p0 : boolean): void ;
  setFontStyle(p0 : FontStyle): void ;
  setFontSize(p0 : FontSize): void ;
}
interface CursesIF {
  begin(): void ;
  end(): void ;
  width : number ;
  height : number ;
  foregroundColor : ColorIF ;
  backgroundColor : ColorIF ;
  moveTo(p0 : number, p1 : number): void ;
  put(p0 : string): void ;
}
interface SystemPreferenceIF {
  version : string ;
  logLevel : number ;
  device : Device ;
}
interface UserPreferenceIF {
  homeDirectory : URLIF ;
  language : Language ;
}
interface VectorIF {
  dx : number ;
  dy : number ;
}
interface ViewPreferenceIF {
  foregroundColor : ColorIF ;
  backgroundColor : ColorIF ;
  textFieldColor : ColorIF ;
}
interface PreferenceIF {
  system : SystemPreferenceIF ;
  user : UserPreferenceIF ;
  view : ViewPreferenceIF ;
}
declare var Preference:         PreferenceIF ;

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

declare function Pipe(): PipeIF ;

declare function Properties(name: string): PropertiesIF | null ;

declare function SpriteActions(): SpriteActionsIF ;

declare function Table(name: string): TableIF | null ;

declare function _SFSymbol(name: string): SymbolIF ;

declare function _Thread(path: string, console: ConsoleIF): ThreadIF | null ;

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

/**
 * @file Result.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class Result<T> {
    private mResult;
    private mError;
    constructor();
    get result(): T | null;
    get error(): Error;
    setResult(value: T): void;
    setError(error: Error): void;
}
declare function Success<T>(val: T): Result<T>;
declare function Failure<T>(err: Error): Result<T>;
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-isEOF.d.ts" />
declare class File {
    mCore: FileIF;
    constructor(core: FileIF);
    core(): FileIF;
    getc(): string | null;
    getl(): string | null;
    put(str: string): void;
    close(): void;
}
declare var _stdin: FileIF;
declare var _stdout: FileIF;
declare var _stderr: FileIF;
declare const stdin: File;
declare const stdout: File;
declare const stderr: File;
interface JSONFileIF {
    read(file: FileIF): object | null;
    write(file: FileIF, src: object): boolean;
}
declare var _JSONFile: JSONFileIF;
declare class JSONFile {
    constructor();
    read(file: File): object | null;
    write(file: File, src: object): boolean;
}
/**
 * @file FileManager.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="File.d.ts" />
declare class FileManagerClass {
    open(url: URLIF, acc: string): File | null;
    fileExists(url: URLIF): boolean;
    isAccessible(url: URLIF): boolean;
    isExecutable(url: URLIF): boolean;
    isReadable(url: URLIF): boolean;
    isWritable(url: URLIF): boolean;
    get currentDirectory(): URLIF;
    get documentDirectory(): URLIF;
    get libraryDirectory(): URLIF;
    get applicationSupportDirectory(): URLIF;
    get resourceDirectory(): URLIF;
    get temporaryDirectory(): URLIF;
    copy(src: URLIF, dst: URLIF): boolean;
    remove(dst: URLIF): boolean;
}
declare let FileManager: FileManagerClass;
/**
 * @file CommandLine.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="Result.d.ts" />
declare namespace CommandLine {
    class Format {
        formatId: number;
        longName: string;
        shortName: string;
        hasParameter: boolean;
        constructor(fid: number, lname: string, sname: string, hasparam: boolean);
    }
    enum ArgumentType {
        option = 0,
        normal = 1
    }
    class OptionArgument {
        format: Format;
        parameter: string;
        constructor(form: Format);
        get formatId(): number;
        get longName(): string;
        get shortName(): string;
    }
    class NormalArgument {
        readonly parameter: string;
        constructor(param: string);
    }
    type Argument = {
        type: ArgumentType.option;
        option: OptionArgument;
    } | {
        type: ArgumentType.normal;
        normal: NormalArgument;
    };
    function decode(argv: string[], formats: Format[]): Result<Argument[]>;
}
/// <reference path="Intf.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class Graphics {
    static isSamePoints(p0: PointIF, p1: PointIF): boolean;
    static distance(p0: PointIF, p1: PointIF): number;
    static addPoints(p0: PointIF, p1: PointIF): PointIF;
}
/**
 * @file Language.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
declare function nameOfLanguage(lang: Language): string;
declare function codeOfLanguage(lang: Language): string;
declare const allLanguages: Language[];
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="func-_Thread.d.ts" />
/// <reference path="func-sleep.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class Semaphore {
    mValue: {
        [key: string]: number;
    };
    constructor(initval: number);
    signal(): void;
    wait(): void;
}
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class CancelException extends Error {
    code: number;
    constructor(code: number);
}
declare function _cancel(): void;
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Semaphore.d.ts" />
/// <reference path="Builtin.d.ts" />
declare function openURL(url: URLIF | string): boolean;
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-_Thread.d.ts" />
/// <reference path="func-sleep.d.ts" />
declare function Thread(name: string, console: ConsoleIF): ThreadIF | null;
declare function waitThread(thread: ThreadIF): void;
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-_SFSymbol.d.ts" />
declare function SFSymbol(sym: Symbols): SymbolIF;
/**
 * @field SpriteField.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Graphics.d.ts" />
/// <reference path="interface-SpriteFieldIF.d.ts" />
/// <reference path="interface-SpriteNodeRefIF.d.ts" />
declare class SpriteField {
    private mCore;
    constructor(field: SpriteFieldIF);
    get size(): SizeIF;
    get nodes(): SpriteNodeRefIF[];
}
/**
 * @file SpriteNode.ts
 */
/// <reference path="Builtin.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="interface-SpriteActionsIF.d.ts" />
/// <reference path="func-SpriteActions.d.ts" />
/// <reference path="SpriteField.d.ts" />
declare class SpriteNode {
    private mCore;
    private mField;
    private mIs1st;
    constructor(core: SpriteNodeIF, field: SpriteFieldIF);
    get material(): SpriteMaterial;
    get identifier(): string;
    get nodeId(): number;
    get field(): SpriteField;
    get currentTime(): number;
    get position(): PointIF;
    get size(): SizeIF;
    get velocity(): VectorIF;
    get mass(): number;
    get density(): number;
    get actions(): SpriteActionsIF;
    run(): void;
    init(): void;
    update(curtime: number): void;
}
/**
 * @file SpriteScene.ts
 */
/// <reference path="Builtin.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="SpriteField.d.ts" />
/// <reference path="SpriteNode.d.ts" />
declare class SpriteScene {
    private mCore;
    private mField;
    private mIs1st;
    constructor(core: SpriteSceneIF, field: SpriteFieldIF);
    get field(): SpriteField;
    get currentTime(): number;
    run(): void;
    init(): void;
    update(time: number): void;
}
/**
 * @file SpriteRadar.ts
 */
/// <reference path="Builtin.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Graphics.d.ts" />
/// <reference path="SpriteField.d.ts" />
/// <reference path="SpriteNode.d.ts" />
declare class SpriteRadar {
    private mNode;
    private mField;
    constructor(node: SpriteNode, field: SpriteField);
    nearNodes(): SpriteNodeRefIF[];
    nearestNode(): SpriteNodeRefIF | null;
    distanceFromNode(node: SpriteNodeRefIF): number;
    private isThisNode;
}
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Thread.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-_runThread.d.ts" />
/// <reference path="func-sleep.d.ts" />
declare function run(path: URLIF | string, args: string[], cons: ConsoleIF): number;
/*
 * Builtin.d.ts: Declaration of type and functions of ArisiaLibrary
 */

declare function _setup_component(root: FrameIF): void ;


declare function _alloc_Frame(): FrameIF ;

/**
 * Transpiler.ts
 */
/// <reference path="KiwiLibrary.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="Frame.d.ts" />
declare function _definePropertyIF(frame: FrameIF, names: string[]): void;
/**
 * Builtin.d.ts : Built-in objects in KiwiComponents
 */

declare function _enterView(path: string, arg: any, cbfunc: (retval: any) => void): void ;
declare function _alert(type: AlertType, message: string, labels: string[], cbfunc: (retval: number) => void): void ;
declare function leaveView(param: any): void ;

declare function _openPanel(title: string, type: FileType, exts: string[], cbfunc: any): void ;
declare function _savePanel(title: string, cbfunc: any): void ;


/// <reference path="ArisiaLibrary.d.ts" />
/// <reference path="Builtin.d.ts" />
declare function openPanel(title: string, type: FileType, exts: string[]): URLIF | null;
declare function savePanel(title: string): URLIF | null;
/// <reference path="ArisiaLibrary.d.ts" />
/// <reference path="Builtin.d.ts" />
declare function alert(type: AlertType, message: string, labels: string[]): number;
declare function enterView(path: string, arg: any): any;

interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
declare function _alloc_Box(): BoxIF ;
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
declare function _alloc_Button(): ButtonIF ;
interface CollectionIF extends FrameIF {
  columnNumber : number ;
  totalNumber(): number ;
  collection : string[] ;
  pressed(p0 : CollectionIF, p1 : number, p2 : number): void ;
}
declare function _alloc_Collection(): CollectionIF ;
interface IconIF extends FrameIF {
  pressed(p0 : FrameIF): void ;
  symbol : string ;
  title : string ;
}
declare function _alloc_Icon(): IconIF ;
interface ImageIF extends FrameIF {
  size(): string ;
}
declare function _alloc_Image(): ImageIF ;
interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
declare function _alloc_Label(): LabelIF ;
interface ListViewIF extends FrameIF {
  isEditable : boolean ;
  items(): string[] ;
  setItems(p0 : string[]): void ;
  selectedItem : string | null ;
  updated : number ;
  visibleRowCounts : number ;
}
declare function _alloc_ListView(): ListViewIF ;
interface PopupMenuIF extends FrameIF {
  setMenus(p0 : MenuItemIF[]): void ;
  selectedItem : number | null ;
  selectByValue(p0 : number): boolean ;
}
declare function _alloc_PopupMenu(): PopupMenuIF ;
interface PropertiesDataIF extends FrameIF {
  name : string ;
  save(): boolean ;
}
declare function _alloc_PropertiesData(): PropertiesDataIF ;
interface RadioButtonsIF extends FrameIF {
  currentIndex : number ;
  columnNum : number ;
  labels : string[] ;
  setEnable(p0 : string, p1 : boolean): void ;
}
declare function _alloc_RadioButtons(): RadioButtonsIF ;
interface ShellIF extends FrameIF {
  console : ConsoleIF ;
  run(p0 : URLIF): void ;
}
declare function _alloc_Shell(): ShellIF ;
interface SpriteIF extends FrameIF {
  background : string ;
  height : number ;
  script : string ;
  nodes : {[name: string]: SpriteNodeDeclIF} ;
  width : number ;
}
declare function _alloc_Sprite(): SpriteIF ;
interface StepperIF extends FrameIF {
  initValue : number ;
  maxValue : number ;
  minValue : number ;
  stepValue : number ;
  updated(p0 : StepperIF, p1 : number): void ;
}
declare function _alloc_Stepper(): StepperIF ;
interface TableDataIF extends FrameIF {
  recordCount : number ;
  fieldName(p0 : number): string ;
  fieldNames(): string[] ;
  select(p0 : any, p1 : string): boolean ;
  remove(p0 : number): boolean ;
  name : string ;
}
declare function _alloc_TableData(): TableDataIF ;
interface TableViewIF extends FrameIF {
  columnCount : number ;
  name : string ;
  rowCount : number ;
}
declare function _alloc_TableView(): TableViewIF ;
interface TerminalIF extends FrameIF {
  console : ConsoleIF ;
}
declare function _alloc_Terminal(): TerminalIF ;
interface TextEditIF extends FrameIF {
  isEditable : boolean ;
  terminal : EscapeCodesIF ;
  backgroundColor : ColorIF ;
}
declare function _alloc_TextEdit(): TextEditIF ;
interface TextFieldIF extends FrameIF {
  entered(p0 : TextFieldIF, p1 : string): void ;
  isEditable : boolean ;
  text : string ;
  number : number ;
  hasBackgroundColor : boolean ;
}
declare function _alloc_TextField(): TextFieldIF ;
interface TimerIF extends FrameIF {
  interval : number ;
  start(): void ;
  stop(): void ;
  addHandler(p0 : (p0 : number) => boolean): boolean ;
}
declare function _alloc_Timer(): TimerIF ;
