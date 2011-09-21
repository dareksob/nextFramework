package nextFramework.drawing.style
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.geom.Matrix;
	import nextFramework.nfProperties;
	import flash.display.Graphics;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfFillStyle extends nfStyle implements IFillStyle
	{
		
		public function nfFillStyle(conf:Object = null) 
		{
			nfProperties.setObjectProperties(this, conf);
		}
		
		public function beginFill(graphics:Graphics):void {
			graphics.beginFill(this.color, this.alpha);
		}
	}

}