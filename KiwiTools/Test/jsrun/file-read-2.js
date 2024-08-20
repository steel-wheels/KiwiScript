"use strict";
/**
 * @file file-read.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    let url = URL("file-read-2.ts");
    if (url == null) {
        console.error("Invalid input file name\n");
        return -1;
    }
    let file = FileManager.open(url, "r");
    if (file == null) {
        console.error("Failed to open the file: " + url.path + "\n");
        return -1;
    }
    let docont = true;
    while (docont) {
        let line = file.getl();
        if (line != null) {
            console.print(line);
        }
        else {
            docont = false;
        }
    }
    return 0;
}
