/**
 * @field SpriteField.ts
 */
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Graphics.d.ts" />
/// <reference path="interface-SpriteFieldIF.d.ts" />
/// <reference path="interface-SpriteNodeRefIF.d.ts" />
declare class SpriteField {
    private mCore;
    constructor(field: SpriteFieldIF);
    get size(): SizeIF;
    get nodes(): SpriteNodeRefIF[];
}
