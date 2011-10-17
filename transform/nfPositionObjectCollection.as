package nextFramework.transform 
{
	import flash.geom.Point;
	import nextFramework.transform.nfPositionObject;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfPositionObjectCollection
	{		
		public function push(positionobject:nfPositionObject):int {
			return this._collection.push(positionobject);
		}
		public function pushByValue(object:Object, position:Point):int {
			return this._collection.push(new nfPositionObject(object, position));
		}
		
		public function objectToPosition(direction:String):void {

			for each(var node:nfPositionObject in this.collection) {
				switch(direction) {
					case nfDirection.X: 
						node.setObjectToPosition(true, false); 
						break;
					case nfDirection.Y: 
						node.setObjectToPosition(false, true); 
						break;
					case nfDirection.XY:
						node.setObjectToPosition();
						break;
				}
			}
		}
		
		private var _collection:Vector.<nfPositionObject> = new Vector.<nfPositionObject>();
		public function get collection():Vector.<nfPositionObject> { 
			return this._collection; 
		}
		
	}

}