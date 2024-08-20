"use strict";
/**
 * @file FileManager.ts
 */
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/File.d.ts"/>
class FileManagerClass {
    open(url, acc) {
        let flif = FileManagerCore.open(url, acc);
        if (flif != null) {
            return new File(flif);
        }
        else {
            return null;
        }
    }
    fileExists(url) {
        return FileManagerCore.fileExists(url);
    }
    isAccessible(url) {
        return FileManagerCore.isAccessible(url);
    }
    isExecutable(url) {
        return FileManagerCore.isExecutable(url);
    }
    isReadable(url) {
        return FileManagerCore.isReadable(url);
    }
    isWritable(url) {
        return FileManagerCore.isWritable(url);
    }
    checkFileType(url) {
        return FileManagerCore.checkFileType(url);
    }
    get currentDirectory() {
        return FileManagerCore.currentDirectory;
    }
    get documentDirectory() {
        return FileManagerCore.documentDirectory;
    }
    get libraryDirectory() {
        return FileManagerCore.libraryDirectory;
    }
    get applicationSupportDirectory() {
        return FileManagerCore.applicationSupportDirectory;
    }
    get resourceDirectory() {
        return FileManagerCore.resourceDirectory;
    }
    get temporaryDirectory() {
        return FileManagerCore.temporaryDirectory;
    }
    copy(src, dst) {
        return FileManagerCore.copy(src, dst);
    }
    remove(dst) {
        return FileManagerCore.remove(dst);
    }
    searchPackage(name) {
        return FileManagerCore.searchPackage(name);
    }
}
let FileManager = new FileManagerClass();
