"use strict";
/**
 * @file screen-size.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    let term = TerminalController;
    term.requestScreenSize();
    let code = term.execute();
    if (isSize(code)) {
        console.print("width = " + code.width + "\n");
        console.print("heigt = " + code.height + "\n");
    }
    else {
        console.print("Failed to get size\n");
    }
    return 0;
}
