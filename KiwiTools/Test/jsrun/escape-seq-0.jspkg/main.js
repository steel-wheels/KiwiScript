"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    let bold_on = EscapeSequences.boldCharacter(true);
    let bold_off = EscapeSequences.boldCharacter(false);
    console.print(bold_on.toString()
        + "Hello, world !!"
        + bold_off.toString()
        + "\n");
    console.print(EscapeSequences.string("Newline code between ->").toString()
        + EscapeSequences.newline().toString()
        + EscapeSequences.string("<-").toString());
    return 0;
}
