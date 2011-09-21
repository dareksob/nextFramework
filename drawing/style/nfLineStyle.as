package nextFramework.drawing.style
{
	import flash.display.Graphics;
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfLineStyle extends nfStyle
	{
		
		function nfLineStyle(conf:Object = null)
		{
			nfProperties.setObjectProperties(this, conf);
		}
		
		public function setStyle(graphics:Graphics):void {
			graphics.lineStyle(this.thickness, this.color, this.alpha, this.pixelHinting, this.scaleMode, this.caps, this.joints, this.miterLimit);
		}
		
		
		//thickness
		private var _thickness:Number;
		public function get thickness():Number { return this._thickness; }
		public function set thickness(value:Number):void 
		{
			this._thickness = value;
		}

		
		//pixelHinting
		private var _pixelHinting:Boolean = false;
		public function get pixelHinting():Boolean { return this._pixelHinting; }
		public function set pixelHinting(value:Boolean):void 
		{
			this._pixelHinting = value;
		}
		
		//scaleMode
		private var _scaleMode:String = 'normal';
		public function get scaleMode():String { return this._scaleMode; }
		public function set scaleMode(value:String):void 
		{
			this._scaleMode = value;
		}
		
		//caps
		private var _caps:String;
		public function get caps():String { return this._caps; }
		public function set caps(value:String):void 
		{
			this._caps = value;
		}
		
		//joints
		private var _joints:String;
		public function get joints():String { return this._joints; }
		public function set joints(value:String):void 
		{
			this._joints = value;
		}
		
		//miterlimit
		private var _miterlimit:Number;
		public function get miterLimit():Number { return this._miterlimit; }
		public function set miterLimit(value:Number):void 
		{
			this._miterlimit = value;
		}
	}

}