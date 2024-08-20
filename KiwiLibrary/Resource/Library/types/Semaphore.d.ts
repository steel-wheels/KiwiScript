/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="func-_Thread.d.ts" />
/// <reference path="func-sleep.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class Semaphore {
    mValue: {
        [key: string]: number;
    };
    constructor(initval: number);
    signal(): void;
    wait(): void;
}
