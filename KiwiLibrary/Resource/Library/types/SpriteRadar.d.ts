/**
 * @file SpriteRadar.ts
 */
/// <reference path="Builtin.d.ts" />
/// <reference path="Enum.d.ts" />
/// <reference path="Intf.d.ts" />
/// <reference path="File.d.ts" />
/// <reference path="Graphics.d.ts" />
/// <reference path="SpriteField.d.ts" />
/// <reference path="SpriteNode.d.ts" />
declare class SpriteRadar {
    private mNode;
    private mField;
    constructor(node: SpriteNode, field: SpriteField);
    nearNodes(): SpriteNodeRefIF[];
    nearestNode(): SpriteNodeRefIF | null;
    distanceFromNode(node: SpriteNodeRefIF): number;
    private isThisNode;
}
