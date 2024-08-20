# System functions

## <code>system</code> function
Execute shell command.

### Prototype
<pre>
system(command: String, input: File, output: File, error: File) -> Process
</pre>

### Description
The [File](../Class/File.md) or [Pipe](../Class/Pipe.md) object can be used. If the <code>Pipe</code> object is passed for <code>output</code> or <code>error</code> parameter, the write file handler of the pipe is *closed* when the process is finished.

### Parameter(s)
|Name           |Type   |Description                    |
|:---           |:----  |:----                          |
|command        |String |Shell command to execute       |
|input          |[File](../Class/File.md) or [Pipe](../Class/Pipe.md) |Input file stream |
|output         |[File](../Class/File.md) or [Pipe](../Class/Pipe.md) |Output file stream |
|error          |[File](../Class/File.md) or [Pipe](../Class/Pipe.md) |Output error stream |

### Return value
When the process to execute the command has been launched with no errors,
the return value is instance of [Process class](../Class/Process.md).
When it failed, the return value will be <code>null</code>.

