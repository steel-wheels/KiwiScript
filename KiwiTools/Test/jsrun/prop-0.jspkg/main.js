"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    console.print("**** prop-0.jspkg\n");
    let p0 = Properties("prop_0");
    if (p0 == null) {
        console.print("failed to load properties\n");
        return 1;
    }
    console.print("count: " + p0.count + "\n");
    let fld0 = p0.value("field1");
    console.print("field1: " + fld0 + "\n");
    return 0;
}
