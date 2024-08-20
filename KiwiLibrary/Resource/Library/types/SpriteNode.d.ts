/**
 * @file SpriteNode.ts
 */
/// <reference path="Builtin.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="interface-SpriteActionsIF.d.ts" />
/// <reference path="func-SpriteActions.d.ts" />
/// <reference path="SpriteField.d.ts" />
declare class SpriteNode {
    private mCore;
    private mField;
    private mIs1st;
    constructor(core: SpriteNodeIF, field: SpriteFieldIF);
    get material(): SpriteMaterial;
    get nodeId(): number;
    get field(): SpriteField;
    get currentTime(): number;
    get position(): PointIF;
    get size(): SizeIF;
    get velocity(): VectorIF;
    get mass(): number;
    get density(): number;
    get actions(): SpriteActionsIF;
    run(): void;
    init(): void;
    isAlive(): boolean;
    update(curtime: number): void;
}
