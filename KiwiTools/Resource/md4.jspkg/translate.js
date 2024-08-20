"use strict";
/**
 * @file translate.ts
 */
/// <reference path="../types/KiwiLibrary.d.ts"/>
/// <reference path="types/config.d.ts"/>
/// <reference path="types/command.d.ts"/>
function translate(output, config) {
    /* Decode header */
    let header = config.headerURL;
    if (header != null) {
        if (!translateURL(output, header, config)) {
            return false;
        }
    }
    /* Decode main documents */
    if (config.fileURLs.length > 0) {
        for (let url of config.fileURLs) {
            if (!translateURL(output, url, config)) {
                return false;
            }
        }
    }
    else {
        return translateFile(output, stdin, config);
    }
    /* Decode footer */
    let footer = config.footerURL;
    if (footer != null) {
        if (!translateURL(output, footer, config)) {
            return false;
        }
    }
    return true;
}
function translateURL(output, input, config) {
    let file = FileManager.open(input, "r");
    if (file != null) {
        if (!translateFile(output, file, config)) {
            return false;
        }
        return true;
    }
    else {
        console.error("[Error] Failed to read file: "
            + input.path + "\n");
        return false;
    }
}
function translateFile(output, input, config) {
    let lines = [];
    let line;
    let docont = true;
    while (docont) {
        line = input.getl();
        if (line != null) {
            let stream = StringStream(line);
            if (!translateStream(output, stream, config)) {
                return false;
            }
        }
        else {
            docont = false;
        }
    }
    ;
    return true;
}
function translateStream(output, stream, config) {
    while (!stream.eof()) {
        let c0 = stream.getc();
        if (c0 != null) {
            if (c0 == config.prefix) {
                if (!translateMacro(output, stream, config)) {
                    return false;
                }
            }
            else {
                output.put(c0);
            }
        }
    }
    return true;
}
function translateMacro(output, stream, config) {
    let orgstr = config.prefix;
    let cmdname = stream.getident();
    if (cmdname == null) {
        output.put(orgstr);
        return true;
    }
    orgstr += cmdname;
    if (!stream.reqc("(")) {
        output.put(orgstr);
        return true;
    }
    orgstr += "(";
    let found = false;
    let docont = true;
    let params = [];
    let paramstr = "";
    let prevc = "";
    let isinstr = false;
    while (docont && !stream.eof()) {
        let c = stream.getc();
        if (c == null) {
            continue;
        }
        orgstr += c;
        switch (c) {
            case ")":
                {
                    if (!isinstr) {
                        if (paramstr.length > 0) {
                            params.push(paramstr);
                        }
                        found = true;
                        docont = false;
                    }
                    else {
                        paramstr += c;
                    }
                }
                break;
            case ",":
                {
                    if (!isinstr) {
                        params.push(paramstr);
                        paramstr = "";
                    }
                    else {
                        paramstr += c;
                    }
                }
                break;
            case "\"":
                {
                    if (prevc != "\\") {
                        isinstr = !isinstr;
                    }
                    paramstr += c;
                }
                break;
            default:
                {
                    paramstr += c;
                }
                break;
        }
        prevc = c;
    }
    if (found) {
        let lines = executeMacro(cmdname, params, config);
        if (lines != null) {
            for (let line of lines) {
                let newstrm = StringStream(line);
                if (!translateStream(output, newstrm, config)) {
                    return false;
                }
            }
            /* continue processing */
        }
        else {
            return false;
        }
    }
    else {
        /* macro is not found */
        output.put(orgstr);
    }
    return translateStream(output, stream, config);
}
