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
