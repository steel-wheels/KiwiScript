"use strict";
/*
 * main.js
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(args) {
    let names = Colors.availableColorNames;
    for (const name of names) {
        console.print(name + "\n");
    }
    return 0;
}
