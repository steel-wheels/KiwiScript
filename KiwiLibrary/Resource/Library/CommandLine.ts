/**
 * @file CommandLine.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Result.d.ts"/>

namespace CommandLine {

export class Format {
	public formatId:	number ;
	public longName:	string ;
	public shortName:	string ;
	public hasParameter:	boolean ;

	constructor(fid: number, lname:string, sname:string, hasparam: boolean){
		this.formatId		= fid ;
		this.longName		= lname ;
		this.shortName		= sname ;
		this.hasParameter	= hasparam ;
	}
}

export enum ArgumentType {
	option	= 0,
	normal	= 1
}

export class OptionArgument {
	public format:		Format ;
	public parameter:	string ;

	constructor(form: Format) {
		this.format	= form ;
		this.parameter	= "" ;
	}

	get formatId(): number {
		return this.format.formatId ;
	}

	get longName(): string {
		return this.format.longName ;
	}
	get shortName(): string {
		return this.format.shortName ;
	}
}

export class NormalArgument  {
	public readonly parameter:	string ;
	constructor(param: string){
		this.parameter = param ;
	}
}

export type Argument =
  | { type: ArgumentType.option, option: OptionArgument}
  | { type: ArgumentType.normal, normal: NormalArgument}
  ;

export function decode(argv: string[], formats: Format[]): Result<Argument[]>
{
	/* Make stream for entire argument string */
	let argstr = argv.join(" ") ;
	let stream = StringStream(argstr) ;

	/* Parse command line */
	let results: Argument[] = [] ;
	stream.skipSpaces() ;
	while(!stream.eof()){
		let c0 = stream.getc() ;
		if(c0 == null){
			return Failure(new SyntaxError("Can not happen")) ;
		}
		if(c0 == "-") {
			let c1 = stream.getc() ;
			if(c1 == null){
				/* Add argument "-" */
				let newarg = new NormalArgument(c0) ;
				results.push({
					type: ArgumentType.normal,
					normal: newarg
				}) ;
				continue ;
			}
			if(c1 == "-") {
				/* get long option name */
				let optname = stream.getident() ;
				if(optname != null){
					/* Decode as long-name option */
					let res = decodeLongOption(stream, optname, formats) ;
					let retval = res.result ;
					if(retval != null){
						results.push(retval) ;
					} else {
						return Failure(res.error) ;
					}
				} else {
					return Failure(new SyntaxError("No option name after '--'")) ;
				}
			} else {
				/* Decode as short-name option */
				let res = decodeShortOption(stream, c1, formats) ;
				let retval = res.result
				if(retval != null){
					results.push(retval) ;
				} else {
					return Failure(res.error) ;
				}
			}
		} else {
			stream.ungetc() ; // restore c1
			let w1 = stream.getword() ;
			if(w1 != null){
				/* Add argument w1 */
				let newarg = new NormalArgument(w1) ;
				results.push({
					type: ArgumentType.normal,
					normal: newarg
				}) ;
			}
		}
		stream.skipSpaces() ;
	}
	return Success(results) ;
}

function decodeShortOption(stream: StringStreamIF, name: string, formats: Format[]): Result<Argument>
{
	let form = searchShortNameOption(formats, name) ;
	if(form != null) {
		let newarg = new OptionArgument(form) ;
		if(form.hasParameter) {
			stream.skipSpaces() ;
			let param = stream.getword() ;
			if(param != null){
				newarg.parameter = param ;
			} else {
				return Failure(new SyntaxError(
				  "Parameter is not give for option: "
				  + name)) ;
			}
		}
		return Success({
			type:	ArgumentType.option,
			option: newarg
		}) ;
	} else {
		return Failure(new SyntaxError("Unknown short name option: "
			+ name)) ;
	}
}

function searchShortNameOption(formats: Format[], name: string): Format | null
{
	for(let form of formats) {
		if(form.shortName.length > 0){
			if(form.shortName == name) {
				return form ;
			}
		}
	}
	return null ;
}

function decodeLongOption(stream: StringStreamIF, name: string, formats: Format[]): Result<Argument>
{
	let form = searchLongNameOption(formats, name) ;
	if(form != null) {
		let newarg = new OptionArgument(form) ;
		if(form.hasParameter) {
			stream.skipSpaces() ;
			let param = stream.getword() ;
			if(param != null){
				newarg.parameter = param ;
			} else {
				return Failure(new SyntaxError(
				  "Parameter is not give for option: "
				  + name));
			}
		}
		return Success({
			type:	ArgumentType.option,
			option: newarg
		}) ;
	} else {
		return Failure(new SyntaxError("Unknown long name option: "
			+ name)) ;
	}
}

function searchLongNameOption(formats: Format[], name: string): Format | null
{
	for(let form of formats) {
		if(form.longName.length > 0){
			if(form.longName == name) {
				return form ;
			}
		}
	}
	return null ;
}

} // End of namespace: CommandLine

