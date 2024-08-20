/**
 * @file FileManager.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="File.d.ts" />
declare class FileManagerClass {
    open(url: URLIF, acc: string): File | null;
    fileExists(url: URLIF): boolean;
    isAccessible(url: URLIF): boolean;
    isExecutable(url: URLIF): boolean;
    isReadable(url: URLIF): boolean;
    isWritable(url: URLIF): boolean;
    checkFileType(url: URLIF): FileType | null;
    get currentDirectory(): URLIF;
    get documentDirectory(): URLIF;
    get libraryDirectory(): URLIF;
    get applicationSupportDirectory(): URLIF;
    get resourceDirectory(): URLIF;
    get temporaryDirectory(): URLIF;
    copy(src: URLIF, dst: URLIF): boolean;
    remove(dst: URLIF): boolean;
    searchPackage(name: string): URLIF | null;
}
declare let FileManager: FileManagerClass;
