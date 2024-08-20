/**
 * @file config.ts
 */
/// <reference path="../../types/KiwiLibrary.d.ts" />
interface Config {
    fileURLs: URLIF[];
    doPrintHelp: boolean;
    doPrintVersion: boolean;
    prefix: string;
    includeURLs: URLIF[];
    headerURL: URLIF | null;
    footerURL: URLIF | null;
}
declare function parseArguments(argv: string[]): Result<Config>;
declare function parseDirectory(dirname: string): Result<URLIF>;
