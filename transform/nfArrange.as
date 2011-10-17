package nextFramework.transform 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import nextFramework.utils.nfBoxPoints;
	import nextFramework.utils.nfObject;
	
	/**
	 * arrange objects in a direction
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfArrange implements IDisposer
	{
		
		function nfArrange(conf:Object = null) {
			nfObject.setProps(this, conf);
		}
		
		/**
		 * set the nfPositionObjectCollection to this list
		 * @param	list
		 * @return	nfArrange
		 */
		public function positionObjects(list:Vector.<Object>):* {
			this.getPositionObjectCollection(list).objectToPosition(this.direction);
			return this;
		}
		
		public function getPositionObjectCollection(list:Vector.<Object>):nfPositionObjectCollection {			
			var position:Point = new Point;
			var positionCollection:nfPositionObjectCollection = new nfPositionObjectCollection;
			
			for (var index:int = 0; index < list.length; index++) {
				var node:DisplayObject = list[index] as DisplayObject;
				
				if (node) {
					var boxPoints:nfBoxPoints = new nfBoxPoints(node);
					
					//offset
					if(index == 0){
						position.x += this.offset.x;
						position.y += this.offset.y;
					}

					position = position.add(new Point(-boxPoints.absLeftTop.x, -boxPoints.absLeftTop.y));
					positionCollection.pushByValue(node, position);
					position = position.add(boxPoints.size).add(boxPoints.absLeftTop);
					
					//spacing
					position.x += this.spacing.x;
					position.y += this.spacing.y;
				}
				
			}
			return positionCollection;
		}
		
		
		/**
		 * spacing
		 */
		protected var _spacing:Object = new Point();
		public function get spacing():Object { 
			return this._spacing; 
		}
		public function set spacing(value:Object):void {
			if (value is Number) {
				_spacing = new Point(Number(value), Number(value));
			}else{
				nfObject.setProps(this._spacing, value);
			}
		}
		public function set spacingX(value:Number):void {
			this._spacing.x = value; 
		}
		public function set spacingY(value:Number):void {
			this._spacing.y = value; 
		}
		
		/**
		 * offset
		 */
		protected var _offset:Object = new Point();
		public function get offset():Object { 
			return this._offset; 
		}
		public function set offset(value:Object):void {
			if (value is Number) {
				_offset = new Point(Number(value), Number(value));
			}else{
				nfObject.setProps(this._spacing, value);
			}
		}
		public function set offsetX(value:Number):void {
			this._offset.x = value; 
		}
		public function set offsetY(value:Number):void {
			this._offset.y = value; 
		}
		
		/**
		 * direction
		 */
		protected var _direction:String = 'x';
		public function get direction():String { 
			return this._direction; 
		}
		public function set direction(value:String):void {
			this._direction = nfDirection.getValue(value, false);
		}
		
		
	}

}