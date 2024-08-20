"use strict";
/**
 * @file SpriteNode.ts
 */
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/interface-SpriteActionsIF.d.ts"/>
/// <reference path="types/func-SpriteActions.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
class SpriteNode {
    constructor(core, field) {
        this.mCore = core;
        this.mField = new SpriteField(field);
        this.mIs1st = true;
    }
    get material() { return this.mCore.material; }
    get nodeId() { return this.mCore.nodeId; }
    get field() { return this.mField; }
    get currentTime() { return this.mCore.currentTime; }
    get position() { return this.mCore.position; }
    get size() { return this.mCore.size; }
    get velocity() { return this.mCore.velocity; }
    get mass() { return this.mCore.mass; }
    get density() { return this.mCore.density; }
    get actions() { return this.mCore.actions; }
    run() {
        let docont = true;
        while (docont) {
            if (this.mCore.trigger.isRunning()) {
                if (this.mIs1st) {
                    this.init();
                    this.mIs1st = false;
                }
                else {
                    if (this.isAlive()) {
                        this.update(this.mCore.currentTime);
                    }
                    else {
                        this.mCore.actions.retire();
                        docont = false;
                    }
                }
                this.mCore.trigger.ack();
            }
        }
    }
    init() {
    }
    isAlive() {
        return true;
    }
    update(curtime) {
    }
}
