/**
 * @file command.ts
 */

/// <reference path="../types/KiwiLibrary.d.ts"/>
/// <reference path="types/config.d.ts"/>

function executeMacro(name: string, parameters: string[], config: Config): string[] | null
{
        //let desc = makeCommandDescription(name, parameters, config) ;
        //console.error("command: " + desc + "\n") ;

        let result: string[] | null ;
        switch(name){
          case "include": {
                result = executeIncludeMacro(parameters, config) ;
          } break ;
          default: {
                console.error("[Error] Unknown macro name: " + name + "\n") ;
                result = null ;
          } break ;
        }
        return result ;
}

function makeCommandDescription(name: string, parameters: string[], config: Config): string {
        let result  = name + "(" ;
        let divider = "" ;
        for(let param of parameters) {
                result += divider + param ;
                divider = "," ;
        }
        return result + ")" ;
}

function executeIncludeMacro(parameters: string[], config: Config): string[] | null
{
        if(parameters.length != 1) {
                console.error("[Error] The include macro requires 1 parameter.\n") ;
                return null ;
        }
        let filename = parameters[0] ;
        if(filename.charAt(0) == "/") {
                let fileurl = URL(filename) ;
                if(fileurl != null){
                        let incfile = FileManager.open(fileurl, "r")  ;
                        if(incfile != null){
                                return fileToLines(incfile, config) ;
                        }
                }
                console.error("[Error] Failed to include file: " + filename + "\n") ;
                return null ;
        } else {
                for(let incdir of config.includeURLs) {
                        let fullurl  = incdir.appending(filename) ;
                        if(fullurl == null){
                                console.error("[Error] Failed to allocate URL") ;
                                continue ;
                        }
                        if(FileManager.isReadable(fullurl)) {
                                let incfile = FileManager.open(fullurl, "r") ;
                                if(incfile != null){
                                        return fileToLines(incfile, config) ;
                                } else {
                                        console.error("[Error] Failed to include file: " + fullurl.path + "\n") ;
                                }
                        }
                }
                console.error("[Error] Failed to include file: " + filename + "\n") ;
                for(let incdir of config.includeURLs) {
                        let fullpath = incdir + "/" + filename ;
                        console.error(" searched: " + fullpath + "\n") ;
                }
                return null ;
        }
}

function fileToLines(file: File, config: Config): string[]
{
        let lines: string[] = [] ;
        let docont = true ;
        while(docont) {
                let line = file.getl() ;
                if(line != null){
                        lines.push(line) ;
                } else {
                        docont = false ;
                }
        }
        file.close() ;
        return lines ;
}
