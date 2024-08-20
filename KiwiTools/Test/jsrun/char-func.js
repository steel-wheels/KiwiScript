"use strict";
/**
 * @file char-func.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    test("a");
    test("3");
    test("_");
    test("-");
    test(" ");
    test("ident0");
    test("ident0-ident1");
    return 0;
}
function test(str) {
    print(str, "isIdentifier", isIdentifier(str));
}
function print(str, funcname, result) {
    console.print(funcname + "(\"" + str + "\") -> "
        + (result ? "true" : "false") + "\n");
}
