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
