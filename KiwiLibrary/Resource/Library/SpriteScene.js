"use strict";
/**
 * @file SpriteScene.ts
 */
/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
/// <reference path="types/SpriteNode.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
class SpriteScene {
    constructor(core, field) {
        this.mCore = core;
        this.mField = new SpriteField(field);
        this.mIs1st = true;
    }
    get field() {
        return this.mField;
    }
    get currentTime() {
        return this.mCore.currentTime;
    }
    run() {
        let docont = true;
        while (docont) {
            if (this.mCore.trigger.isRunning()) {
                if (this.mIs1st) {
                    this.init();
                    this.mIs1st = false;
                }
                else {
                    this.update(this.mCore.currentTime);
                }
                this.mCore.trigger.ack();
            }
        }
    }
    init() {
    }
    update(time) {
    }
    finish() {
        this.mCore.finish();
    }
}
