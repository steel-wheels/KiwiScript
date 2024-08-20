/**
 * @file config.ts
 */

/// <reference path="../types/KiwiLibrary.d.ts"/>

interface Config
{
	fileURLs:	URLIF[] ;
	doPrintHelp:	boolean ;
	doPrintVersion:	boolean ;

	prefix:		string ;
	includeURLs:	URLIF[] ;

	headerURL:	URLIF | null ;
	footerURL:	URLIF | null ;
}

function parseArguments(argv: string[]): Result<Config>
{
	const CommandId = {
		help		: 0,
		version		: 1,
		include		: 2,
		header		: 3,
		footer 		: 4
	} ;

	let formats: CommandLine.Format[] = [
		new CommandLine.Format(CommandId.help,
			"help", "h", false),
		new CommandLine.Format(CommandId.version,
			"version", "v", false),
		new CommandLine.Format(CommandId.include,
			"include", "I", true),
		new CommandLine.Format(CommandId.header,
			"header",  "",  true),
		new CommandLine.Format(CommandId.footer,
			"footer",  "",  true)
	] ;

	/* Decode arguments */
	let dargs = CommandLine.decode(argv, formats) ;
	let args: Array<CommandLine.Argument>

	let result = dargs.result ;
	if(result != null){
		args = result ;
	} else {
		return Failure(dargs.error) ;
	}

	/* Parse arguments */
	let fileurls:  URLIF[]  = [] ;
	let dohelp:    boolean	= false ;
	let dovers:    boolean	= false ;
	let incurls:   URLIF[]  = [] ;
	let header:    URLIF | null    = null ;
	let footer:    URLIF | null    = null ;

	for(let arg of args) {
		switch(arg.type){
		case CommandLine.ArgumentType.normal:
			let fileurl = URL(arg.normal.parameter) ;
			if(fileurl != null){
				fileurls.push(fileurl) ;
			} else {
				console.error("[Error] Failed to allocate URL");
			}
		break ;
		case CommandLine.ArgumentType.option:
			let oarg = arg.option ;
			switch(oarg.formatId) {
			  case CommandId.help:
				dohelp = true ;
			  break ;
			  case CommandId.version:
				dovers = true ;
			  break ;
			  case CommandId.include: {
				let res  = parseDirectory(oarg.parameter) ;
				let url  = res.result ;
				if(url != null){
					incurls.push(url) ;
				} else {
					return Failure(res.error) ;
				}
			  } break ;
			  case CommandId.header: {
				let res  = parseDirectory(oarg.parameter) ;
				let url  = res.result ;
				if(url != null){
					header = url ;
				} else {
					return Failure(res.error) ;
				}
			  } break ;
			  case CommandId.footer: {
				let res  = parseDirectory(oarg.parameter) ;
				let url  = res.result ;
				if(url != null){
					footer = url ;
				} else {
					return Failure(res.error) ;
				}
			  } break ;
			}
		break ;
		}
	}

	/* Add path of current directory as a last include path */
	let cururl = URL(".") ;
	if(cururl != null){
		incurls.push(cururl) ;
	} else {
		console.error("[Error] Failed to allocate URL") ;
	}
	return Success({
	    fileURLs:		fileurls,
	    doPrintHelp:	dohelp,
	    doPrintVersion:	dovers,
	    prefix:		"@",
	    includeURLs:	incurls,
	    headerURL:		header,
	    footerURL:		footer
	}) ;
}

function parseDirectory(dirname: string): Result<URLIF>
{
	let dirurl = URL(dirname) ;
	if(dirurl != null){
		if(FileManager.fileExists(dirurl)){
			return Success(dirurl) ;
		} else {
			let err = Error("The include "
			 + "directory is not found: "
			 + dirurl.path) ;
 			return Failure(err) ;
		}
	} else {
		let err = Error("Failed to allocate URL: " + dirname) ;
		return Failure(err) ;
	}
}
