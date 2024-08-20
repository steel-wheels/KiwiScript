/**
 * @field SpriteField.ts
 */

/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Graphics.d.ts"/>
/// <reference path="types/interface-SpriteFieldIF.d.ts"/>
/// <reference path="types/interface-SpriteNodeRefIF.d.ts"/>

class SpriteField
{
        private mCore:  SpriteFieldIF ;

        constructor(field: SpriteFieldIF){
                this.mCore 	= field ;
        }

        get size(): SizeIF {
                return this.mCore.size ;
        }

	get nodes(): SpriteNodeRefIF[] {
		return this.mCore.nodes ;
	}
}

