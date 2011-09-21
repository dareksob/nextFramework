package nextFramework.collection 
{
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	
	public class nfMap2D
	{
		
		private var _map:Vector.<Vector.<nfMap2DNode>>;
		
		public function nfMap2D() 
		{
			this._map = new Vector.<Vector.<nfMap2DNode>>();
		}
		
		public function get xlength():uint {
			if (this.ylength > 0) {
				return this._map[0].length;
			}
			return 0
		}
		public function get ylength():uint {
			return this._map.length as uint;
		}
		
		public function getNode(x:uint, y:uint):nfMap2DNode {
			return this._map[y][x];
		}
		public function setNodeObject(x:uint, y:uint, object:Object):nfMap2D {
			this._map[y][x].object = object;
			return this;
		}
		public function isNode(x:uint, y:uint):Boolean {
			if (this.ylength > y) {
				if (this.xlength > x) {
					return true;
				}
			}
			return false;
		}
		public function getNeighborNodes(x:uint, y:uint, level:uint = 1):Vector.<nfMap2DNode> {
			var nodes:Vector.<nfMap2DNode> = new Vector.<nfMap2DNode>();
			for (var yoffset:int = -level; yoffset <= level; yoffset++) {
				for (var xoffset:int = -level; xoffset <= level; xoffset++) {
					var posX:uint = x + xoffset;
					var posY:uint = y + yoffset;

					if (!(posX == x && posY == y)) {
						if (this.isNode(posX, posY)) {
							nodes.push(this.getNode(posX, posY));
						}
					}
				}
			}
			return nodes;
		}

		
		public function each(func:Function):nfMap2D {
			for (var y:uint = 0; y < this._map.length; y++) {
				for (var x:uint = 0; x < this._map[y].length; x++) {
					func(this._map[y][x]);
				}
			}
			return this;
		}
		
		public function fill(func:Function, xcount:uint, ycount:uint):nfMap2D {
				
			for (var y:uint = 0; y < ycount; y++) {
				if (this._map.length-1 < y) {
					this._map.push(new Vector.<nfMap2DNode>());
				}
				for (var x:uint = 0; x < xcount; x++) {
					this._map[y][x] = new nfMap2DNode(x, y, func());
				}
			}
			return this;
		}
		
	}

}