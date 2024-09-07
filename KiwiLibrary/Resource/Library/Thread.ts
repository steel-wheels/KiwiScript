/*
 * Thread.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/func-_Thread.d.ts"/>
/// <reference path="types/func-sleep.d.ts"/>

function Thread(name: string, console: ConsoleIF): ThreadIF | null {
	return _Thread(name, console);
}

function waitThread(thread: ThreadIF): void
{
	while(thread.status != ProcessStatus.running){
		sleep(0.001) ;
	}
}

function runThread(path: URLIF | string, args: string[],
		   				cons: ConsoleIF): number {

	let thread = _runThread(path, cons) ;
	if(thread != null){
		thread.start(args) ;
		waitThread(thread) ;
		return thread.exitCode ;
	} else {
		return -1 ;
	}
}

