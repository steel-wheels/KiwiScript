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
  searchPackage(p0 : string): URLIF | null ;
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
  availableColorNames : string[] ;
}
interface ConsoleIF {
  print(p0 : string): void ;
  error(p0 : string): void ;
  log(p0 : string): void ;
  scan(): string | null ;
}
interface CollectionDataIF {
  count : number ;
  item(p0 : number): string | null ;
  addItem(p0 : IconIF): void ;
  addItems(p0 : IconIF[]): void ;
}
interface IconIF {
  tag : number ;
  symbol : SymbolIF ;
  title : string ;
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
  checkFileType(p0 : URLIF): FileType | null ;
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
interface ReadlineCoreIF {
  execute(): string | null ;
}
interface TriggerIF {
  trigger(): void ;
  isRunning(): boolean ;
  ack(): void ;
}
interface SpriteNodeRefIF {
  material : SpriteMaterial ;
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
  retire(): void ;
}
interface SpriteNodeIF {
  material : SpriteMaterial ;
  nodeId : number ;
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
  finish(): void ;
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
  clear(): void ;
}
interface SystemPreferenceIF {
  version : string ;
  logLevel : number ;
  device : Device ;
  style : InterfaceStyle ;
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
  rootBackgroundColor : ColorIF ;
  controlBackgroundColor : ColorIF ;
  labelColor : ColorIF ;
  textColor : ColorIF ;
  controlColor : ColorIF ;
  terminalForegroundColor : ColorIF ;
  terminalBackgroundColor : ColorIF ;
  graphicsForegroundColor : ColorIF ;
  graphiceBackgroundColor : ColorIF ;
}
interface PreferenceIF {
  system : SystemPreferenceIF ;
  user : UserPreferenceIF ;
  view : ViewPreferenceIF ;
}
