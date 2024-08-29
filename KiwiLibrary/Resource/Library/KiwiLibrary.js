"use strict";
/**
 * @file Result.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
class Result {
    constructor() {
        this.mResult = null;
        this.mError = null;
    }
    get result() {
        return this.mResult;
    }
    get error() {
        if (this.mError != null) {
            return this.mError;
        }
        else {
            return Error("Unregistered error");
        }
    }
    setResult(value) {
        this.mResult = value;
    }
    setError(error) {
        this.mError = error;
    }
}
function Success(val) {
    let newres = new Result();
    newres.setResult(val);
    return newres;
}
function Failure(err) {
    let newres = new Result();
    newres.setError(err);
    return newres;
}
"use strict";
/* File.js */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-isEOF.d.ts"/>
class File {
    constructor(core) {
        this.mCore = core;
    }
    core() {
        return this.mCore;
    }
    getc() {
        while (true) {
            let c = this.mCore.getc();
            if (c != null) {
                if (isEOF(c)) {
                    return null;
                }
                else {
                    return c;
                }
            }
        }
    }
    getl() {
        while (true) {
            let s = this.mCore.getl();
            if (s != null) {
                if (isEOF(s)) {
                    return null;
                }
                else {
                    return s;
                }
            }
        }
    }
    put(str) {
        this.mCore.put(str);
    }
    close() {
        this.mCore.close();
    }
}
const stdin = new File(_stdin);
const stdout = new File(_stdout);
const stderr = new File(_stderr);
class JSONFile {
    constructor() {
    }
    read(file) {
        return _JSONFile.read(file.mCore);
    }
    write(file, src) {
        return _JSONFile.write(file.mCore, src);
    }
}
"use strict";
/**
 * @file FileManager.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/File.d.ts"/>
class FileManagerClass {
    open(url, acc) {
        let flif = FileManagerCore.open(url, acc);
        if (flif != null) {
            return new File(flif);
        }
        else {
            return null;
        }
    }
    fileExists(url) {
        return FileManagerCore.fileExists(url);
    }
    isAccessible(url) {
        return FileManagerCore.isAccessible(url);
    }
    isExecutable(url) {
        return FileManagerCore.isExecutable(url);
    }
    isReadable(url) {
        return FileManagerCore.isReadable(url);
    }
    isWritable(url) {
        return FileManagerCore.isWritable(url);
    }
    checkFileType(url) {
        return FileManagerCore.checkFileType(url);
    }
    get currentDirectory() {
        return FileManagerCore.currentDirectory;
    }
    get documentDirectory() {
        return FileManagerCore.documentDirectory;
    }
    get libraryDirectory() {
        return FileManagerCore.libraryDirectory;
    }
    get applicationSupportDirectory() {
        return FileManagerCore.applicationSupportDirectory;
    }
    get resourceDirectory() {
        return FileManagerCore.resourceDirectory;
    }
    get temporaryDirectory() {
        return FileManagerCore.temporaryDirectory;
    }
    copy(src, dst) {
        return FileManagerCore.copy(src, dst);
    }
    remove(dst) {
        return FileManagerCore.remove(dst);
    }
    searchPackage(name) {
        return FileManagerCore.searchPackage(name);
    }
}
let FileManager = new FileManagerClass();
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
"use strict";
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
class Graphics {
    static isSamePoints(p0, p1) {
        return p0.x == p1.x && p0.y == p1.y;
    }
    static distance(p0, p1) {
        let dx = p0.x - p1.x;
        let dy = p0.y - p1.y;
        return Math.sqrt(dx * dx + dy * dy);
    }
    static addPoints(p0, p1) {
        return Point(p0.x + p1.x, p0.y + p1.y);
    }
}
"use strict";
/**
 * @file Language.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
function nameOfLanguage(lang) {
    let result;
    switch (lang) {
        case Language.chinese:
            result = "chinese";
            break;
        case Language.deutch:
            result = "deutch";
            break;
        case Language.english:
            result = "english";
            break;
        case Language.french:
            result = "french";
            break;
        case Language.italian:
            result = "italian";
            break;
        case Language.japanese:
            result = "japanese";
            break;
        case Language.korean:
            result = "korean";
            break;
        case Language.russian:
            result = "russian";
            break;
        case Language.spanish:
            result = "spanish";
            break;
        case Language.others:
            result = "others";
            break;
    }
    return result;
}
function codeOfLanguage(lang) {
    let result;
    switch (lang) {
        case Language.chinese:
            result = "zh-CN";
            break;
        case Language.deutch:
            result = "de";
            break;
        case Language.english:
            result = "en";
            break;
        case Language.french:
            result = "fr";
            break;
        case Language.italian:
            result = "it";
            break;
        case Language.japanese:
            result = "ja";
            break;
        case Language.korean:
            result = "ko";
            break;
        case Language.russian:
            result = "ru";
            break;
        case Language.spanish:
            result = "es";
            break;
        case Language.others:
            result = "?";
            break;
    }
    return result;
}
const allLanguages = [
    Language.chinese,
    Language.deutch,
    Language.english,
    Language.french,
    Language.italian,
    Language.japanese,
    Language.korean,
    Language.russian,
    Language.spanish,
    Language.others
];
"use strict";
/*
 * Semaphone.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/func-_Thread.d.ts"/>
/// <reference path="types/func-sleep.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
class Semaphore {
    constructor(initval) {
        this.mValue = {};
        this.mValue["count"] = initval;
    }
    signal() {
        let val = this.mValue["count"];
        if (val != null) {
            this.mValue["count"] = val - 1;
        }
        else {
            console.log("No count in Semaphore");
        }
    }
    wait() {
        while (true) {
            let count = this.mValue["count"];
            if (count != null) {
                if (count >= 0) {
                    sleep(0.1);
                }
                else {
                    break;
                }
            }
        }
    }
}
"use strict";
/*
 * Process.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
class CancelException extends Error {
    constructor(code) {
        super("CancelException");
        this.code = code;
    }
}
function _cancel() {
    throw new CancelException(ExitCode.exception);
}
"use strict";
/*
 * openURL.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Semaphore.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
function openURL(url) {
    let result = false;
    let sem = new Semaphore(0);
    let cbfunc = function (res) {
        result = res;
        sem.signal(); // Tell finish operation
    };
    _openURL(url, cbfunc);
    sem.wait(); // Wait finish operation
    return result;
}
"use strict";
/*
 * Readline.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-_Thread.d.ts"/>
/// <reference path="types/func-sleep.d.ts"/>
function readline() {
    while (true) {
        let str = _readlineCore.execute();
        if (str != null) {
            return str;
        }
    }
    return "";
}
"use strict";
/*
 * Thread.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-_Thread.d.ts"/>
/// <reference path="types/func-sleep.d.ts"/>
function Thread(name, console) {
    return _Thread(name, console);
}
function waitThread(thread) {
    while (thread.status != ProcessStatus.running) {
        sleep(0.001);
    }
}
"use strict";
/**
 * @field SpriteField.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Graphics.d.ts"/>
/// <reference path="types/interface-SpriteFieldIF.d.ts"/>
/// <reference path="types/interface-SpriteNodeRefIF.d.ts"/>
class SpriteField {
    constructor(field) {
        this.mCore = field;
    }
    get size() {
        return this.mCore.size;
    }
    get nodes() {
        return this.mCore.nodes;
    }
}
"use strict";
/**
 * @file SpriteNode.ts
 */
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/interface-SpriteActionsIF.d.ts"/>
/// <reference path="types/func-SpriteActions.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
class SpriteNode {
    constructor(core, field) {
        this.mCore = core;
        this.mField = new SpriteField(field);
        this.mIs1st = true;
    }
    get material() { return this.mCore.material; }
    get nodeId() { return this.mCore.nodeId; }
    get field() { return this.mField; }
    get currentTime() { return this.mCore.currentTime; }
    get position() { return this.mCore.position; }
    get size() { return this.mCore.size; }
    get velocity() { return this.mCore.velocity; }
    get mass() { return this.mCore.mass; }
    get density() { return this.mCore.density; }
    get actions() { return this.mCore.actions; }
    run() {
        let docont = true;
        while (docont) {
            if (this.mCore.trigger.isRunning()) {
                if (this.mIs1st) {
                    this.init();
                    this.mIs1st = false;
                }
                else {
                    if (this.isAlive()) {
                        this.update(this.mCore.currentTime);
                    }
                    else {
                        this.mCore.actions.retire();
                        docont = false;
                    }
                }
                this.mCore.trigger.ack();
            }
        }
    }
    init() {
    }
    isAlive() {
        return true;
    }
    update(curtime) {
    }
}
"use strict";
/**
 * @file SpriteScene.ts
 */
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
/// <reference path="types/SpriteNode.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
class SpriteScene {
    constructor(core, field) {
        this.mCore = core;
        this.mField = new SpriteField(field);
        this.mIs1st = true;
    }
    get field() {
        return this.mField;
    }
    get currentTime() {
        return this.mCore.currentTime;
    }
    run() {
        let docont = true;
        while (docont) {
            if (this.mCore.trigger.isRunning()) {
                if (this.mIs1st) {
                    this.init();
                    this.mIs1st = false;
                }
                else {
                    this.update(this.mCore.currentTime);
                }
                this.mCore.trigger.ack();
            }
        }
    }
    init() {
    }
    update(time) {
    }
    finish() {
        this.mCore.finish();
    }
}
"use strict";
/**
 * @file SpriteRadar.ts
 */
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Graphics.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
/// <reference path="types/SpriteNode.d.ts"/>
class SpriteRadar {
    constructor(node, field) {
        this.mNode = node;
        this.mField = field;
    }
    nearNodes() {
        let pos = this.mNode.position;
        let nodes0 = this.mField.nodes;
        let nodes1 = nodes0.filter((n) => !this.isThisNode(n));
        let sorted = nodes1.sort((a, b) => Graphics.distance(a.position, pos)
            - Graphics.distance(b.position, pos));
        return sorted;
    }
    nearestNode() {
        let nodes = this.nearNodes();
        if (nodes.length >= 1) {
            return nodes[0];
        }
        else {
            return null;
        }
    }
    distanceFromNode(node) {
        return Graphics.distance(this.mNode.position, node.position);
    }
    isThisNode(noderef) {
        if (this.mNode.material == noderef.material) {
            if (this.mNode.nodeId == noderef.nodeId) {
                return true;
            }
        }
        return false;
    }
}
"use strict";
/*
 * run.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Thread.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-_runThread.d.ts"/>
/// <reference path="types/func-sleep.d.ts"/>
function run(path, args, cons) {
    let thread = _runThread(path, cons);
    if (thread != null) {
        thread.start(args);
        waitThread(thread);
        return thread.exitCode;
    }
    else {
        return -1;
    }
}
