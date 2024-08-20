# class: EscapeSequences

## Interface
<pre>
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

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.


