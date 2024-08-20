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
