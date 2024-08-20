/**
 * @file Result.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>

class Result<T>
{
	private mResult:	T | null ;
	private mError:		Error | null ;

	constructor(){
		this.mResult	= null ;
		this.mError	= null ;
	}

	get result(): T | null {
		return this.mResult ;
	}

	get error(): Error {
		if(this.mError != null) {
			return this.mError ;
		} else {
			return Error("Unregistered error") ;
		}
	}

	setResult(value: T) {
		this.mResult = value ;
	}

	setError(error: Error) {
		this.mError = error ;
	}
}

function Success<T>(val: T): Result<T>
{
	let newres = new Result<T>() ;
	newres.setResult(val) ;
        return newres ;
}

function Failure<T>(err: Error): Result<T>
{
	let newres = new Result<T>() ;
	newres.setError(err) ;
        return newres ;
}
