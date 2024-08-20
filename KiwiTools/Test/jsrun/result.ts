/*
 * result.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function func_success(): Result<number>
{
	return Success(12.3) ;
}

function func_failure(): Result<number>
{
	return Failure(new Error("Error message")) ;
}

function print_result(result: Result<number>): void
{
	let retval = result.result ;
	if(retval != null){
		console.print("success = " + retval) ;
	} else {
		console.print("failure = " + result.error.message) ;
	}
	console.print("\n") ;
}

function main(argv: string[])
{
	print_result(func_success()) ;
	print_result(func_failure()) ;
	return 0 ;
}

