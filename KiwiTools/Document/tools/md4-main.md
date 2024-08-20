# md4

## Name
md4 - Macro processor

## Synopsys
````
md4 [options] [files] 
````

## Description
The `md4` is macro processor. 
This command processes the macro (called `md4 macro`) in the input document and output the execution result.

## Argument
### `files`
One or more file names. The will be parsed in order. 
The header file is inserted before them (see `--header` option).
And foolter file is appended after them (see `--footer` option).

## Option
### `-h`, `--help`
Output the message about usage of this tool to standard output.

### `-v`, `--version`
Output the version infomation to standard output.

### `--header`
````
--header file
````
The file which is inserted before all of the other files.
It can contain macros.
You can not give multiple this options.

### `--footer`
````
--footer file
````
The file which is appended to the output.
It can contain macros.
You can not give multiple this options.

### `-i`, `--include`
````
--include dir
````
The include path of the file which is included by [include macro](./#include_macro). You can define multiple include pathes. The path information is refered by [include macro](#include-macro).

## Syntax of the macro
The macro is started by *prefix code*.
At the default setting, the *prefix code* is `@`.
The indentifier which follows the prefix is `command name`.

````
macro: '@' command_name '(' parameters ')

command_name: _IDENTIFIER_

parameters : The list of parameters which is divied by ','
           ;

parameter  : _IDENTIFIER_
           | number
           | string
````


## md4 Macros
### `include` macro
````
@include(path/included.txt)
````
This macro include the context of `included.txt` where the macro is decribed. The parameter is a path if the file. The path is relative path against the current directory or include directories which is give by [include option](#i---include).

## Related links
* [KiwiTools](../../README.md): The package which contains this command.
