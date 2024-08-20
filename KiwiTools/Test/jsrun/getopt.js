"use strict";
/*
 * getopt.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(argv) {
    const CommandId = {
        help: 0,
        version: 1,
        line: 2
    };
    let formats = [
        new CommandLine.Format(CommandId.help, "help", "h", false),
        new CommandLine.Format(CommandId.version, "version", "v", false),
        new CommandLine.Format(CommandId.line, "line", "l", true)
    ];
    decode(formats, ["a"]);
    decode(formats, ["-h", "-v"]);
    decode(formats, ["-l100", "--line", "200", "300"]);
    return 0;
}
function decode(formats, argv) {
    let cmdline = argv.join(" ");
    console.print("input: " + cmdline + "\n");
    let res = CommandLine.decode(argv, formats);
    let retval = res.result;
    if (retval != null) {
        let args = retval;
        for (let arg of args) {
            switch (arg.type) {
                case CommandLine.ArgumentType.normal:
                    let narg = arg.normal;
                    console.print("normal: parameter = \"" + narg.parameter + "\"\n");
                    break;
                case CommandLine.ArgumentType.option:
                    let oarg = arg.option;
                    console.print("option: short-name = \"" + oarg.shortName + "\"\n");
                    console.print("option: long-name  = \"" + oarg.longName + "\"\n");
                    console.print("option: parameter  = \"" + oarg.parameter + "\"\n");
                    break;
            }
        }
    }
    else {
        console.error("[Errorl Failed to decode: " + res.error.message + "\n");
    }
}
