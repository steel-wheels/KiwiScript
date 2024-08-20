/// <reference path="ArisiaPlatform.d.ts" />
declare function func_success(): Result<number>;
declare function func_failure(): Result<number>;
declare function print_result(result: Result<number>): void;
declare function main(argv: string[]): number;
