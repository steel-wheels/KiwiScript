/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="func-_Thread.d.ts" />
/// <reference path="func-sleep.d.ts" />
declare function Thread(name: string, console: ConsoleIF): ThreadIF | null;
declare function waitThread(thread: ThreadIF): void;
