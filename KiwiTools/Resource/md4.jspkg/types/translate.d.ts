/**
 * @file translate.ts
 */
/// <reference path="../../types/KiwiLibrary.d.ts" />
/// <reference path="config.d.ts" />
/// <reference path="command.d.ts" />
declare function translate(output: File, config: Config): boolean;
declare function translateURL(output: File, input: URLIF, config: Config): boolean;
declare function translateFile(output: File, input: File, config: Config): boolean;
declare function translateStream(output: File, stream: StringStreamIF, config: Config): boolean;
declare function translateMacro(output: File, stream: StringStreamIF, config: Config): boolean;
