package nextFramework.transform 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import nextFramework.transform.nfPositionObjectCollection;
	import nextFramework.translate.nfSize;
	import nextFramework.utils.nfBoxPoints;
	
	/**
	 * @todo spacing is the width and height
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	
	public class nfTableArrange extends nfArrange
	{
		
		function nfTableArrange(conf:Object = null) {
			super(conf);
		}
		
		/**
		 * set the nfPositionObjectCollection to this list
		 * @param	list
		 * @return	nfTableArrange
		 */
		override public function positionObjects(list:Vector.<Object>):* 
		{
			this.getPositionObjectCollection(list).objectToPosition(nfDirection.XY);
			return this;
		}
		
		/**
		 * return a nfPositionObjectCollection based by the table datas
		 * @param	list
		 * @return	nfPositionObjectCollection
		 */
		override public function getPositionObjectCollection(list:Vector.<Object>):nfPositionObjectCollection 
		{
			var position:Point = new Point;
			var positionCollection:nfPositionObjectCollection = new nfPositionObjectCollection;

			var cellNum:int = 1;
			var invertDirection:String = this._direction == "x" ? "y" : "x";
			
			if (!this._cellSize) {
				this._cellSize = new nfSize;
			}

			for (var index:int = 0; index < list.length; index++) {
				var node:Object = list[index];
				
				if (node is DisplayObject) {
					var offsetPosition:Point = position.clone();
					var boxPoints:nfBoxPoints = new nfBoxPoints(node);
					var boxSize:nfSize = new nfSize(boxPoints.width, boxPoints.height);

					offsetPosition = offsetPosition.subtract(nfAlignPosition.getPointByBoxPoint(this._alignPosition, boxPoints));
					offsetPosition = offsetPosition.add(this.offset as Point);
					
					positionCollection.pushByValue(node, offsetPosition);
			
					if (cellNum >= this._cellCount) {
						trace(cellNum);
						position[invertDirection] += this._cellSize.getByAxis(invertDirection) + this._spacing[invertDirection];
						position[this._direction] = 0;
						cellNum = 1;
					}else {
						
						position[this._direction] += this._cellSize.getByAxis(this._direction) + this._spacing[this._direction];
						cellNum++;
					}
				}
				
			}
			return positionCollection;
		}
		
				
		/**
		 * cell count for one direction
		 */
		private var _cellCount:int = 5;
		public function get cellCount():int { 
			return this._cellCount; 
		}
		public function set cellCount(value:int):void {
			this._cellCount = value;
		}
		
		/*
		 * cells
		 */
		private var _cellSize:Object = null;
		public function get cellSize():Object { 
			return this._cellCount; 
		}
		public function set cellSize(value:Object):void {
			if (value is Number) {
				_cellSize = new nfSize(Number(value), Number(value));
			}else {
				_cellSize = (new nfSize()).setOptions(value);
			}
		}
		
		/*
		 * alignPosition
		 */
		private var _alignPosition:String = 'absLeftTop';
		public function get alignPosition():String { 
			return this._alignPosition; 
		}
		public function set alignPosition(value:String):void {
			this._alignPosition = value;
		}
		
	}

}