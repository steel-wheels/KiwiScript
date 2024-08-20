/**
 * @file Result.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class Result<T> {
    private mResult;
    private mError;
    constructor();
    get result(): T | null;
    get error(): Error;
    setResult(value: T): void;
    setError(error: Error): void;
}
declare function Success<T>(val: T): Result<T>;
declare function Failure<T>(err: Error): Result<T>;
