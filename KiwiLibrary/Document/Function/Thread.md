# Function: Thread
Construct the Thread object.

<pre>
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-_Thread.d.ts" />
/// <reference path="func-sleep.d.ts" />
declare function Thread(name: string, console: ConsoleIF): ThreadIF | null;
declare function waitThread(thread: ThreadIF): void;
declare function runThread(path: URLIF | string, args: string[], cons: ConsoleIF): number;

</pre>

This function is defined in <code>Thread.ts</code> in KiwiLibrary resource.

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.


