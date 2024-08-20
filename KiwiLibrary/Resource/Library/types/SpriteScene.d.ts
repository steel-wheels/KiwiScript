/**
 * @file SpriteScene.ts
 */
/// <reference path="Builtin.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="SpriteField.d.ts" />
/// <reference path="SpriteNode.d.ts" />
declare class SpriteScene {
    private mCore;
    private mField;
    private mIs1st;
    constructor(core: SpriteSceneIF, field: SpriteFieldIF);
    get field(): SpriteField;
    get currentTime(): number;
    run(): void;
    init(): void;
    update(time: number): void;
    finish(): void;
}
