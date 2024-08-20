"use strict";
/**
 * @file file-func.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    let url = URL("file-func.ts");
    if (url == null) {
        return -1;
    }
    let result;
    result = FileManager.isReadable(url);
    let resstr = result ? "OK" : "Error";
    console.print("[file-func] summary: " + resstr + "\n");
    return result ? 0 : -1;
}
