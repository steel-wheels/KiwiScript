/// <reference path="types/Intf.d.ts"/>
/// <reference path="types/Enum.d.ts"/>
/// <reference path="types/Builtin.d.ts"/>

class Graphics
{
	static isSamePoints(p0: PointIF, p1: PointIF): boolean {
		return p0.x == p1.x && p0.y == p1.y ;
	}

	static distance(p0: PointIF, p1: PointIF): number {
		let dx = p0.x - p1.x ;
		let dy = p0.y - p1.y ;
		return Math.sqrt(dx*dx + dy*dy) ;
	}

	static addPoints(p0: PointIF, p1: PointIF): PointIF {
		return Point(p0.x + p1.x, p0.y + p1.y) ;
	}
}

