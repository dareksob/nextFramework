package nextFramework.transform 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import nextFramework.debug.nfDrawRect;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	import nextFramework.utils.nfBoxPoints;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.02 beta
	 */
	 
	public final class nfAlign
	{
		function nfAlign(aligntoobject:Object, conf:Object = null) {
			this.alignToObject = aligntoobject;
			nfProperties.setObjectProperties(this, conf);
		}

		public function alignList(list:Vector.<Object>):nfAlign {
			this.getAlignPositionCollection(list).objectToPosition(this.direction);
			return this;
		}
		
		public function getAlignPositionCollection(list:Vector.<Object>):nfPositionObjectCollection {
			var positionCollection:nfPositionObjectCollection = new nfPositionObjectCollection;
			var alignBoxPoints:nfBoxPoints = new nfBoxPoints(this.alignToObject);
		
			
			if(alignBoxPoints){
				for each(var node:Object in list) {
					if (node is DisplayObject) {
						var boxPoints:nfBoxPoints = new nfBoxPoints(node);
						
						var position:Point = new Point;
						var alignPosition:nfAlignPosition = new nfAlignPosition(this.alignPosition);

						//offset 
						position = position.add(this.offset);
						
						//start with top left position inner
						position = position.add(new Point( -boxPoints.absLeftTop.x, -boxPoints.absLeftTop.y));
						
						switch(alignPosition.value) {
							case nfAlignPosition.LEFTTOP:
									if (!this.inner) {
										position = position.subtract(boxPoints.size);
									}
								break;
							case nfAlignPosition.CENTERTOP:
									position.x += alignBoxPoints.centerPointRelative.x - boxPoints.centerPointRelative.x;
									if (!this.inner) {
										position.y -= boxPoints.size.y;
									}
								break;
							case nfAlignPosition.RIGHTTOP:
									position.x += alignBoxPoints.rightTop.x;
									
									if (this.inner) {
										position.x -= boxPoints.size.x;
									}else {
										position.y -= boxPoints.size.y;
									}
								break;
							case nfAlignPosition.LEFTCENTER:
									position.y += alignBoxPoints.centerPointRelative.y - boxPoints.centerPointRelative.y;
									if (!this.inner) {
										position.x -= boxPoints.size.x;
									}
								break;
							case nfAlignPosition.CENTER:
									position = position.add(alignBoxPoints.centerPointRelative).subtract(boxPoints.centerPointRelative);
								break;
							case nfAlignPosition.RIGHTCENTER:
									position.y += alignBoxPoints.centerPointRelative.y - boxPoints.centerPointRelative.y;
									position.x += alignBoxPoints.rightTop.x;
									if (this.inner) {
										position.x -= boxPoints.size.x;
									}
								break;
							case nfAlignPosition.LEFTBOTTOM:
									position.y += alignBoxPoints.size.y;
									if (this.inner) {
										position.y -= boxPoints.size.y;
									}else {
										position.x -= boxPoints.size.x;
									}
								break;
							case nfAlignPosition.CENTERBOTTOM:
									position.x += alignBoxPoints.centerPointRelative.x - boxPoints.centerPointRelative.x;
									position.y += alignBoxPoints.size.y;
									if (this.inner) {
										position.y -= boxPoints.size.y;
									}
								break;
							case nfAlignPosition.RIGHTBOTTOM:
									position.y += alignBoxPoints.size.y;
									position.x += alignBoxPoints.rightTop.x;
									if (this.inner) {
										position = position.subtract(boxPoints.size);
									}
								break;
						}

						positionCollection.pushByValue(node, position);
					}
				}
			}
			return positionCollection;
		}
		
		/*
		 * offset
		 */
		private var _offset:Point = new Point();
		public function get offset():Point { 
			return this._offset; 
		}
		public function set offset(value:Point):void {
			this._offset = value; 
		}
		public function set offsetX(value:Number):void {
			this._offset.x = value; 
		}
		public function set offsetY(value:Number):void {
			this._offset.y = value; 
		}

		/*
		 * direction
		 */
		private var _direction:String = 'xy';
		public function get direction():String { 
			return this._direction; 
		}
		public function set direction(value:String):void {
			this._direction = value;
		}
		
		/*
		 * inner
		 */
		private var _inner:Boolean = true;
		public function get inner():Boolean { 
			return this._inner; 
		}
		public function set inner(value:Boolean):void {
			this._inner = value;
		}
		
		/*
		 * alignposition
		 */
		private var _alignPosition:String = 'leftTop';
		public function get alignPosition():String { 
			return this._alignPosition; 
		}
		public function set alignPosition(value:String):void {
			this._alignPosition = value;
		}
		
		/*
		 * alignToObject
		 */
		private var _alignToObject:Object;
		public function get alignToObject():Object { 
			return this._alignToObject; 
		}
		public function set alignToObject(value:Object):void {
			this._alignToObject = value;
		}
		
	}

}