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

class SpriteNode
{
        private mCore:  SpriteNodeIF ;
        private mField: SpriteField ;
	private mIs1st: boolean ;

        constructor(core: SpriteNodeIF, field: SpriteFieldIF){
                this.mCore 	= core ;
                this.mField 	= new SpriteField(field) ;
		this.mIs1st	= true ;
        }

	get material(): SpriteMaterial  { return this.mCore.material ;  }
	get nodeId(): number		{ return this.mCore.nodeId ;	}

	get field(): SpriteField	{ return this.mField ;		}
	get currentTime(): number	{ return this.mCore.currentTime; }

        get position(): PointIF         { return this.mCore.position ;   }
        get size(): SizeIF              { return this.mCore.size ;       }
        get velocity(): VectorIF        { return this.mCore.velocity ;	}
        get mass(): number              { return this.mCore.mass ;	}
        get density(): number           { return this.mCore.density ;    }

	get actions(): SpriteActionsIF  { return this.mCore.actions ;	}

	run() {
		let docont = true ;
		while(docont){
			if(this.mCore.trigger.isRunning()){
				if(this.mIs1st){
					this.init() ;
					this.mIs1st = false ;
				} else {
				    	if(this.isAlive()){
					    this.update(this.mCore.currentTime);
					} else {
					    this.mCore.actions.retire() ;
					    docont = false ;
					}
				}
				this.mCore.trigger.ack() ;
			}
		}
	}

        init(){
	}

	isAlive(): boolean {
	    return true ;
	}

        update(curtime: number) {
        }
}

