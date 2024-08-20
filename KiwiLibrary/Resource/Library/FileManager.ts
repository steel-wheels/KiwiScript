/**
 * @file FileManager.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/File.d.ts"/>

class FileManagerClass
{
        open(url: URLIF, acc: string): File | null {
                let flif = FileManagerCore.open(url, acc) ;
                if(flif != null){
                        return new File(flif) ;
                } else {
                        return null ;
                }
        }

        fileExists(url: URLIF): boolean {
                return FileManagerCore.fileExists(url) ;
        }

        isAccessible(url: URLIF): boolean {
                return FileManagerCore.isAccessible(url) ;
        }

        isExecutable(url: URLIF): boolean {
                return FileManagerCore.isExecutable(url) ;
        }

        isReadable(url: URLIF): boolean {
                return FileManagerCore.isReadable(url) ;
        }

        isWritable(url: URLIF): boolean {
                return FileManagerCore.isWritable(url) ;
        }

	checkFileType(url: URLIF): FileType | null {
                return FileManagerCore.checkFileType(url) ;
	}

        get currentDirectory(): URLIF {
                return FileManagerCore.currentDirectory ;
        }

        get documentDirectory(): URLIF {
                return FileManagerCore.documentDirectory ;
        }

        get libraryDirectory(): URLIF {
                return FileManagerCore.libraryDirectory ;
        }

        get applicationSupportDirectory(): URLIF {
                return FileManagerCore.applicationSupportDirectory ;
        }

        get resourceDirectory(): URLIF {
                return FileManagerCore.resourceDirectory ;
        }

        get temporaryDirectory(): URLIF {
                return FileManagerCore.temporaryDirectory ;
        }

        copy(src: URLIF, dst: URLIF): boolean {
                return FileManagerCore.copy(src, dst) ;
        }

        remove(dst: URLIF): boolean {
                return FileManagerCore.remove(dst) ;
        }

	searchPackage(name: string): URLIF | null {
		return FileManagerCore.searchPackage(name) ;
	}
}

let FileManager = new FileManagerClass() ;
