/*
 * Readline.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-_Thread.d.ts"/>
/// <reference path="types/func-sleep.d.ts"/>

function readline(): string {
	while(true){
		let str = _readlineCore.execute() ;
		if(str != null){
			return str ;
		}
	}
	return "" ;
}

