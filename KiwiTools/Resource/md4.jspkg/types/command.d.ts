/**
 * @file command.ts
 */
/// <reference path="../../types/KiwiLibrary.d.ts" />
/// <reference path="config.d.ts" />
declare function executeMacro(name: string, parameters: string[], config: Config): string[] | null;
declare function makeCommandDescription(name: string, parameters: string[], config: Config): string;
declare function executeIncludeMacro(parameters: string[], config: Config): string[] | null;
declare function fileToLines(file: File, config: Config): string[];
