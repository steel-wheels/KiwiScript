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
