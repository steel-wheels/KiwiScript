# EscapeCodes

## Interface
<pre>
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

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.


