# jsh: JavaScript shell

## Introduction
<code>jsh</code> is a shell program.
It supports *JavaShellScript* for the programming.

The *JavaShellScript* is the extention of JavaScript to support usual shell scripting. You can embedd the following operations into the JavaScript code:
* command call
* file redirection
* pipe

This is a sample script. The prefix <code>\></code> switches the script mode.
<code>
let target = "world"           // JavaScript
\> echo "hello, ${target}"      // Shell script
</code>

## Overview


### JavaShellScript
You can mix the JavaScript statements and shell script statements into a JavaShellScript file. 

### Interactive mode
When the <code>jsh</code> is launched without any options, the program is started under *shell mode*.
You can execute built-in shell script program by the command line.
<pre>
bash$ jsh       # launch the jsh without any arguments
jsh> ls
</pre>

If you give script file name as an argument, the shell script is executed:

script file: hello.js
<code>
console.log("hello, world\n") ;
</code>
<pre>
bash$ jsh hello.js
hello, world !!
</pre>
The script file whose file extension is <code>jsh</code>.

## Implementation
The <code>jsh</code> has transpiler which convert the JavaShell script into the native JavaScript.

### The script mode
There are two modes which is refered by script tranpiler.
The mode vill have following 2 modes:
* shell script mode 
* JavaScript mode

### Variable Pool
The variable which is defined/refered in the shell script will be stored to/loaded from <code>Envitonment</code> variabled pool.

### Translation examples
#### Example 1
The shell command will be replaced by <code>runThreads</code> function call.
<pre>
ls -l
</pre>

<pre>
let ls_thread = {
        name: "ls",
        args: {"-l"},
        input: null, output: null, error: null
} ;
env.exit_code = runThreads({ls_thread}, console) ;
</pre>

#### Example 2
This is a sample shell script which uses redirect and pipe.
<pre>
cat a.txt b.txt c.txt | wc -l > out.txt
</pre>

The transpiler generates this script:
<pre>
let cat_thread = {
        name: "cat",
        args: {"a.txt", "b.txt", "c.txt"},
        input: null, output: null, error: null
} ;
let pipe_thread = {
        name: "wc",
        args: {"-l"},
        input: null, output: "out.txt", error: null 
} ;
env.exit_code = runThreads({cat_thread, pipe_thread}, console) ;
</pre>

#### Example 3
<pre>
let message = "hello" ;
> echo "hello, ${message}"
</pre>

<pre>
let message = "hello" ;
let tmp_var = "hello, " + _pool.get("message") ;
let echo_thread = {
        name: "echo"
        args: {tmp_var},
        input: null, output: null, error: null
}
env.exit_code = runThreads({echo_thread}, console) ;
</pre>