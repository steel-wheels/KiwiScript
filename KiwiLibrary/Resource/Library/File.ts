/* File.js */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-isEOF.d.ts"/>

class File
{
    mCore : FileIF ;

    constructor(core : FileIF){
        this.mCore = core ;
    }

    core(): FileIF {
        return this.mCore ;
    }

    getc(): string | null {
        while(true){
            let c = this.mCore.getc() ;
            if(c != null){
                if(isEOF(c)){
                    return null ;
                } else {
                    return c ;
                }
            }
        }
    }

    getl(): string | null {
        while(true){
            let s  = this.mCore.getl() ;
            if(s != null){
                if(isEOF(s)) {
                    return null ;
                } else {
                    return s ;
                }
            }
        }
    }

    put(str: string): void {
        this.mCore.put(str) ;
    }

    close(): void {
        this.mCore.close() ;
    }
}

/* Global variables */
declare var _stdin:  FileIF ;
declare var _stdout: FileIF ;
declare var _stderr: FileIF ;

const stdin  = new File(_stdin) ;
const stdout = new File(_stdout) ;
const stderr = new File(_stderr) ;

/* JSON file */
interface JSONFileIF {
	read(file: FileIF): object | null ;
	write(file: FileIF, src: object): boolean ;
}

declare var _JSONFile:		JSONFileIF ;

class JSONFile
{
	constructor(){
	}

	read(file: File): object | null {
		return _JSONFile.read(file.mCore) ;
	}

	write(file: File, src: object): boolean {
		return _JSONFile.write(file.mCore, src) ;
	}
}

