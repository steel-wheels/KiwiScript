"use strict";
/**
 * @file command.ts
 */
/// <reference path="../types/ArisiaPlatform.d.ts"/>
var CommandType;
(function (CommandType) {
    CommandType["ls"] = "ls";
})(CommandType || (CommandType = {}));
class Command {
    constructor(ctype, args) {
        this.commandType = ctype;
        this.arguments = args;
    }
    execute() {
        switch (this.commandType) {
            case CommandType.ls:
                {
                    this.lsCommand();
                }
                break;
        }
    }
    lsCommand() {
        console.print("ls command\n");
    }
    dump() {
        console.print(this.commandType + ":" +
            this.arguments.join(" ") + "\n");
    }
}
class CommandLineParser {
    constructor() {
    }
    parse(cmdline) {
        let words = cmdline.trim().split(/[ 	]+/);
        if (words.length == 0) {
            return null;
        }
        let cmdname = words[0];
        let args = words.slice(1);
        let result;
        switch (cmdname) {
            case CommandType.ls:
                {
                    /* ls command */
                    result = new Command(CommandType.ls, args);
                }
                break;
            default:
                {
                    console.print("Unknown command: " + words[0] + "\n");
                    result = null;
                }
                break;
        }
        return result;
    }
}
