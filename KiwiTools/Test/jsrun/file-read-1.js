"use strict";
/**
 * @file file-read.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    let docont = true;
    while (docont) {
        let line = stdin.getl();
        if (line != null) {
            console.print(line);
        }
        else {
            docont = false;
        }
    }
    return 0;
}
