"use strict";
/**
 * @file tokenize.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    let result = true;
    result && (result = test0("a b c"));
    result && (result = test0("\"a b\" c"));
    result && (result = test0("12.3 + 0x5"));
    result && (result = test0("12.3 * 0x5"));
    return result ? 0 : 1;
}
function test0(str) {
    let tokens = tokenize(str);
    if (tokens != null) {
        console.print("token count = " + tokens.length + "\n");
        for (let token of tokens) {
            console.print("token = " + token.type + "\n");
        }
        return true;
    }
    else {
        return false;
    }
}
