# jsrun

## Name
`jsrun` - JavaScript executor

## Synopsys
````
jsrun [options] source-file [arguments]
````

## Description
The `jsrun` command executes the given JavaScript program. Following file formats are supported:
* Plane file (`*.js`): A text file which contains JavaScript code.
* JavaScript package (`*jspkg/`): The package directory which contains multiple script file and resources. For more details, see [manifest file](../../KiwiEngine/Document/manifest.md).

The `jsrun` program search `main` function after all library files and the source file are parsed,
and call the `main` function if it exists.

About main function, see the section [main function](#main-function).

### Options
#### `-h`, `--help`
Output help message and quit the command.

#### `--version`
Output the version information and quit the command.

### Main function
In usually, you will define the main function. The function has following interface.
````
main(argv: string[]): number
````

When the return value of the function is zero, it means no error occured, otherwise some runtime error occured.

### Arguments
The arguments for the program is given after
the source file. The source file name and their arguments are packed into an `argv` array.

For example. if you execute the command line
````
jsrun test.js a b c
````
In this case, the `argv` array will have following items:
````
argv.length == 4
argv[0] = test.js
argv[1] = a
argv[2] = b
argv[3] = c
````

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developper's web site
* [KiwiTools](../README.md): The repository which contains this.

