/**
 * @file CommandLine.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="Builtin.d.ts" />
/// <reference path="Result.d.ts" />
declare namespace CommandLine {
    class Format {
        formatId: number;
        longName: string;
        shortName: string;
        hasParameter: boolean;
        constructor(fid: number, lname: string, sname: string, hasparam: boolean);
    }
    enum ArgumentType {
        option = 0,
        normal = 1
    }
    class OptionArgument {
        format: Format;
        parameter: string;
        constructor(form: Format);
        get formatId(): number;
        get longName(): string;
        get shortName(): string;
    }
    class NormalArgument {
        readonly parameter: string;
        constructor(param: string);
    }
    type Argument = {
        type: ArgumentType.option;
        option: OptionArgument;
    } | {
        type: ArgumentType.normal;
        normal: NormalArgument;
    };
    function decode(argv: string[], formats: Format[]): Result<Argument[]>;
}
