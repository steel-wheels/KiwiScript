/*
 * main.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argv: string[]): number
{
	console.print("Hello, from main\n") ;

	let th0 = Thread("thread_0", console) ;
	if(th0 != null){
	    th0.start(["a", "b"]) ;

	    console.print("wait until thread finish\n") ;
	    waitThread(th0) ;
	    console.print("exit code = " + th0.exitCode + "\n") ;
	} else {
	    console.error("Failed to allocate thread\n") ;
	}

	return 0 ;
}

