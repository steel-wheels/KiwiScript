/**
 * @file SpriteRadar.ts
 */

/// <reference path="types/Builtin.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/File.d.ts"/>
/// <reference path="types/Graphics.d.ts"/>
/// <reference path="types/SpriteField.d.ts"/>
/// <reference path="types/SpriteNode.d.ts"/>

class SpriteRadar
{
	private mNode:  SpriteNode ;
        private mField: SpriteField ;

        constructor(node: SpriteNode, field: SpriteField){
                this.mNode 	= node ;
                this.mField 	= field ;
        }

	nearNodes(): SpriteNodeRefIF[] {
		let pos    = this.mNode.position ;
		let nodes0 = this.mField.nodes ;
		let nodes1 = nodes0.filter((n) => !this.isThisNode(n)) ;
		let sorted = nodes1.sort((a, b) =>
		    Graphics.distance(a.position, pos) 
		  - Graphics.distance(b.position, pos) 
		) ;
		return sorted ;
	}
	
	nearestNode(): SpriteNodeRefIF | null {
		let nodes = this.nearNodes() ;
		if(nodes.length >= 1){
			return nodes[0] ;
		} else {
			return null ;
		}
	}

	distanceFromNode(node: SpriteNodeRefIF): number {
		return Graphics.distance(this.mNode.position,
					 node.position) ;
	}

	private isThisNode(noderef: SpriteNodeRefIF): boolean {
		if(this.mNode.material == noderef.material){
			if(this.mNode.nodeId == noderef.nodeId) {
				return true ;
			}
		}
		return false ;
	}
}

