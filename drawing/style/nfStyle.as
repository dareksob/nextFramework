package nextFramework.drawing.style
{
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfStyle
	{
		
		function nfStyle(conf:Object = null) 
		{
			nfProperties.setObjectProperties(this, conf);
		}

		//color
		private var _color:uint = 0;
		public function get color():uint { return this._color; }
		public function set color(value:uint):void 
		{
			this._color = value;
		}
		
		//alpha
		private var _alpha:Number = 1;
		public function get alpha():Number { return this._alpha; }
		public function set alpha(value:Number):void 
		{
			this._alpha = value;
		}
	}

}