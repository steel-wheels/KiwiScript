"use strict";
/**
 * @file main.ts
 */
/// <reference path="../types/KiwiLibrary.d.ts"/>
/// <reference path="types/config.d.ts"/>
/// <reference path="types/translate.d.ts"/>
function printHelp() {
    let message = "usage: md4 [options] [files]\n"
        + " [option]\n"
        + "   --help, -h       : Output this message\n"
        + "   --version, -v    : Output version information\n"
        + "   --header <file>  : Header file\n"
        + "   --footer <file>  : Footer file\n";
    console.print(message);
}
function printVersion() {
    let message = "md4 version 0.1\n";
    console.print(message);
}
function main(argv) {
    /* Parse command line and get config */
    let config;
    let res = parseArguments(argv);
    let retval = res.result;
    if (retval != null) {
        config = retval;
    }
    else {
        console.error("[Error] " + res.error.message + "\n");
        return -1;
    }
    /* Check configs to execute before translation */
    if (config.doPrintHelp) {
        printHelp();
        return 1;
    }
    if (config.doPrintVersion) {
        printVersion();
        return 1;
    }
    if (translate(stdout, config)) {
        return 0;
    }
    else {
        return 1;
    }
}
