/*
 * Process.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>

class CancelException extends Error
{
	code: number ;

	constructor (code: number){
		super("CancelException") ;
		this.code = code ;
	}
}

function _cancel() {
	throw new CancelException(ExitCode.exception) ;
}

