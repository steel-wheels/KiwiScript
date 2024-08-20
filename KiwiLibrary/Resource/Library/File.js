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
