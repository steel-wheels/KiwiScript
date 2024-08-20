/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-isEOF.d.ts" />
declare class File {
    mCore: FileIF;
    constructor(core: FileIF);
    core(): FileIF;
    getc(): string | null;
    getl(): string | null;
    put(str: string): void;
    close(): void;
}
declare var _stdin: FileIF;
declare var _stdout: FileIF;
declare var _stderr: FileIF;
declare const stdin: File;
declare const stdout: File;
declare const stderr: File;
interface JSONFileIF {
    read(file: FileIF): object | null;
    write(file: FileIF, src: object): boolean;
}
declare var _JSONFile: JSONFileIF;
declare class JSONFile {
    constructor();
    read(file: File): object | null;
    write(file: File, src: object): boolean;
}
