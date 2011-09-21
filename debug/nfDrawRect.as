package nextFramework.debug 
{
	import caurina.transitions.SpecialProperty;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nextFramework.nfProperties;
	import nextFramework.utils.nfBoxPoints;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfDrawRect
	{
		function nfDrawRect(drawingonsprite:Sprite, object:Object, conf:Object = null) {
			nfProperties.setObjectProperties(this, conf);
			this.drawingOnSprite = drawingonsprite;
			this.object = object;
		}
		
		public function draw(clear:Boolean = true):Boolean { 
			if (this.drawingOnSprite is Sprite && this.object != null) {
				this.drawing(clear); 
				return true;
			}
			return false;
		}
		
		static public function drawOn(drawingonsprite:Sprite, object:Object, conf:Object = null, clear:Boolean = true):Boolean {
			return (new nfDrawRect(drawingonsprite, object, conf)).draw(clear);
		}
		
		
		private function drawing(clear:Boolean = true):void {
			var boxPoints:nfBoxPoints = nfBoxPoints.create(this.object);
			if (clear) { this.drawingOnSprite.graphics.clear(); }
			
			
			if (this.showRectPoints) {
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.getByStage('leftTop'), dotColor.corner, 1, dotSize.corner);
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.getByStage('rightTop'), dotColor.corner, 1, dotSize.corner);
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.getByStage('leftBottom'), dotColor.corner, 1, dotSize.corner);
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.getByStage('rightBottom'), dotColor.corner, 1, dotSize.corner);
			}

			if(this.showCenterPoint){
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.getByStage('centerPoint'), dotColor.center, 1, dotSize.center);
			}
			
			if(this.showPositionPoint){
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.stagePostition, dotColor.position, 1, dotSize.position);
			}
			
			if(this.showAbsLeftTop){
				this.drawDot(this.drawingOnSprite.graphics, boxPoints.getByStage('absLeftTop'), dotColor.position, 0.5, dotSize.center);
			}
			
		}
		
		private function drawDot(graphics:Graphics, position:Point, color:uint, alpha:Number, dotSize:Number) {
			graphics.beginFill(color, alpha);
			graphics.drawCircle(position.x, position.y, dotSize);
			graphics.endFill();
		}
		
		
		
		
		/*
		 * spriteOn
		 */
		private var _drawingOnSprite:Sprite;
		public function get drawingOnSprite():Sprite { 
			return this._drawingOnSprite; 
		}
		public function set drawingOnSprite(value:Sprite) {
			this._drawingOnSprite = value; 
		}
		
		/*
		 * object
		 */
		private var _object:Object;
		public function get object():Object { 
			return this._object;
		}
		public function set object(value:Object) {
			this._object = value; 
		}
		
		/*
		 * showRectPoints
		 */
		private var _showRectPoints:Boolean = true;
		public function get showRectPoints():Boolean { 
			return this._showRectPoints; 
		}
		public function set showRectPoints(value:Boolean) {
			this._showRectPoints = value; 
		}
		
		/*
		 * showPositionPoint
		 */
		private var _showPositionPoint:Boolean = true;
		public function get showPositionPoint():Boolean { 
			return this._showPositionPoint; 
		}
		public function set showPositionPoint(value:Boolean) {
			this._showPositionPoint = value; 
		}
		
		/*
		 * showCenterPoint
		 */
		private var _showCenterPoint:Boolean = true;
		public function get showCenterPoint():Boolean { 
			return this._showCenterPoint; 
		}
		public function set showCenterPoint(value:Boolean) {
			this._showCenterPoint = value; 
		}
		
		/*
		 * showAbsLeftTop
		 */
		private var _showAbsLeftTop:Boolean = true;
		public function get showAbsLeftTop():Boolean { 
			return this._showAbsLeftTop; 
		}
		public function set showAbsLeftTop(value:Boolean) {
			this._showAbsLeftTop = value; 
		}
		
		/*
		 * dotSize
		 */
		private var _dotSize:Object = { center: 2, corner: 1, position: 3 };
		public function get dotSize():Object {
			return this._dotSize;
		}
		public function get dotSizeCorner():Number { 
			return this._dotSize.corner; 
		}
		public function set dotSizeCorner(value:Number) {
			this._dotSize.corner = value; 
		}
		
		public function get dotSizeCenter():Number { 
			return this._dotSize.center; 
		}
		public function set dotSizeCenter(value:Number) {
			this._dotSize.center = value; 
		}
		
		public function get dotSizePosition():Number { 
			return this._dotSize.position; 
		}
		public function set dotSizePosition(value:Number) {
			this._dotSize.position = value; 
		}
		
		/*
		 * color
		 */
		private var _dotColor:Object = { center: 0xFF0000, corner: 0x00FF00, position: 0x0000FF };
		public function get dotColor():Object {
			return this._dotColor;
		}
		public function get dotColorCorner():uint { 
			return this._dotColor.corner; 
		}
		public function set dotColorCorner(value:uint) {
			this._dotColor.corner = value; 
		}
		
		public function get dotColorCenter():uint { 
			return this._dotColor.center; 
		}
		public function set dotColorCenter(value:uint) {
			this._dotColor.center = value; 
		}
		
		public function get dotColorPosition():uint { 
			return this._dotColor.position; 
		}
		public function set dotColorPosition(value:uint) {
			this._dotColor.position = value; 
		}

		
	}

}