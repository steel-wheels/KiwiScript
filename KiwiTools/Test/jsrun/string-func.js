"use strict";
/**
 * @file type.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    test("abc");
    test(" \t ");
    test("a_0B");
    test("123");
    return 0;
}
function test(str) {
    print(str, "isSpace", isSpace(str));
    print(str, "isNumber", isNumber(str));
    print(str, "isAlphaNumetics", isAlphaNumerics(str));
    print(str, "isIdentifier", isIdentifier(str));
}
function print(str, funcname, result) {
    console.print(funcname + "(\"" + str + "\") -> "
        + (result ? "true" : "false") + "\n");
}
