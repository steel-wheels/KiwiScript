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
