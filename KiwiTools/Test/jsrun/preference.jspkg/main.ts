/*
 * main.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(argc: string[]):number
{
	console.print("Test: Preference\n") ;
	let result = true ;
	result &&= testLanguage() ;

	return result ? 0 : -1 ;
}

function testLanguage(): boolean
{
	let lang = Preference.user.language ;
	console.print("lang-value: " + lang + "\n") ;
	switch(lang){
	  case Language.english:
		console.print("lang: english\n") ;
	  break ;
	  case Language.japanese:
		console.print("lang: japanese\n") ;
	  break ;
	  default:
		console.print("lang: ?\n") ;
	  break ;
	}

	for(let lang of allLanguages){
		let name = nameOfLanguage(lang) ;
		console.print("enum: " + name + " = " + lang + "\n") ;
	}

	return true ;
}

