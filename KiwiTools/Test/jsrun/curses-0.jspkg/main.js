"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaLibrary.d.ts"/>
function main(argv) {
    Curses.begin();
    Curses.foregroundColor = Colors.yellow;
    Curses.backgroundColor = Colors.blue;
    console.print("Hello, world !!\n");
    sleep(2);
    Curses.end();
    return 0;
}
