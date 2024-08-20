/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class CancelException extends Error {
    code: number;
    constructor(code: number);
}
declare function _cancel(): void;
