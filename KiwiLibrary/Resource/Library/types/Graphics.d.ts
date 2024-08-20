/// <reference path="Intf.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Builtin.d.ts" />
declare class Graphics {
    static isSamePoints(p0: PointIF, p1: PointIF): boolean;
    static distance(p0: PointIF, p1: PointIF): number;
    static addPoints(p0: PointIF, p1: PointIF): PointIF;
}
