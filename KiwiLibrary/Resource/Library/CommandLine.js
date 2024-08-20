"use strict";
/**
 * @file CommandLine.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Result.d.ts"/>
var CommandLine;
(function (CommandLine) {
    class Format {
        constructor(fid, lname, sname, hasparam) {
            this.formatId = fid;
            this.longName = lname;
            this.shortName = sname;
            this.hasParameter = hasparam;
        }
    }
    CommandLine.Format = Format;
    let ArgumentType;
    (function (ArgumentType) {
        ArgumentType[ArgumentType["option"] = 0] = "option";
        ArgumentType[ArgumentType["normal"] = 1] = "normal";
    })(ArgumentType = CommandLine.ArgumentType || (CommandLine.ArgumentType = {}));
    class OptionArgument {
        constructor(form) {
            this.format = form;
            this.parameter = "";
        }
        get formatId() {
            return this.format.formatId;
        }
        get longName() {
            return this.format.longName;
        }
        get shortName() {
            return this.format.shortName;
        }
    }
    CommandLine.OptionArgument = OptionArgument;
    class NormalArgument {
        constructor(param) {
            this.parameter = param;
        }
    }
    CommandLine.NormalArgument = NormalArgument;
    function decode(argv, formats) {
        /* Make stream for entire argument string */
        let argstr = argv.join(" ");
        let stream = StringStream(argstr);
        /* Parse command line */
        let results = [];
        stream.skipSpaces();
        while (!stream.eof()) {
            let c0 = stream.getc();
            if (c0 == null) {
                return Failure(new SyntaxError("Can not happen"));
            }
            if (c0 == "-") {
                let c1 = stream.getc();
                if (c1 == null) {
                    /* Add argument "-" */
                    let newarg = new NormalArgument(c0);
                    results.push({
                        type: ArgumentType.normal,
                        normal: newarg
                    });
                    continue;
                }
                if (c1 == "-") {
                    /* get long option name */
                    let optname = stream.getident();
                    if (optname != null) {
                        /* Decode as long-name option */
                        let res = decodeLongOption(stream, optname, formats);
                        let retval = res.result;
                        if (retval != null) {
                            results.push(retval);
                        }
                        else {
                            return Failure(res.error);
                        }
                    }
                    else {
                        return Failure(new SyntaxError("No option name after '--'"));
                    }
                }
                else {
                    /* Decode as short-name option */
                    let res = decodeShortOption(stream, c1, formats);
                    let retval = res.result;
                    if (retval != null) {
                        results.push(retval);
                    }
                    else {
                        return Failure(res.error);
                    }
                }
            }
            else {
                stream.ungetc(); // restore c1
                let w1 = stream.getword();
                if (w1 != null) {
                    /* Add argument w1 */
                    let newarg = new NormalArgument(w1);
                    results.push({
                        type: ArgumentType.normal,
                        normal: newarg
                    });
                }
            }
            stream.skipSpaces();
        }
        return Success(results);
    }
    CommandLine.decode = decode;
    function decodeShortOption(stream, name, formats) {
        let form = searchShortNameOption(formats, name);
        if (form != null) {
            let newarg = new OptionArgument(form);
            if (form.hasParameter) {
                stream.skipSpaces();
                let param = stream.getword();
                if (param != null) {
                    newarg.parameter = param;
                }
                else {
                    return Failure(new SyntaxError("Parameter is not give for option: "
                        + name));
                }
            }
            return Success({
                type: ArgumentType.option,
                option: newarg
            });
        }
        else {
            return Failure(new SyntaxError("Unknown short name option: "
                + name));
        }
    }
    function searchShortNameOption(formats, name) {
        for (let form of formats) {
            if (form.shortName.length > 0) {
                if (form.shortName == name) {
                    return form;
                }
            }
        }
        return null;
    }
    function decodeLongOption(stream, name, formats) {
        let form = searchLongNameOption(formats, name);
        if (form != null) {
            let newarg = new OptionArgument(form);
            if (form.hasParameter) {
                stream.skipSpaces();
                let param = stream.getword();
                if (param != null) {
                    newarg.parameter = param;
                }
                else {
                    return Failure(new SyntaxError("Parameter is not give for option: "
                        + name));
                }
            }
            return Success({
                type: ArgumentType.option,
                option: newarg
            });
        }
        else {
            return Failure(new SyntaxError("Unknown long name option: "
                + name));
        }
    }
    function searchLongNameOption(formats, name) {
        for (let form of formats) {
            if (form.longName.length > 0) {
                if (form.longName == name) {
                    return form;
                }
            }
        }
        return null;
    }
})(CommandLine || (CommandLine = {})); // End of namespace: CommandLine
