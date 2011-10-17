package nextFramework.drawing.styles
{
	import flash.display.Graphics;
	import nextFramework.utils.nfObject;
	
	/**
	 * base line style
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class Line extends AbstractStyle implements IStyle
	{
		
		function Line(conf:Object = null)
		{
			nfObject.setProps(this, conf);
		}
		
		public function setStyle(graphics:Graphics):void {
			graphics.lineStyle(this.thickness, this.color, this.alpha, this.pixelHinting, this.scaleMode, this.caps, this.joints, this.miterLimit);
		}
		
		/** thickness */
		public var thickness:Number;

		/** pixelHinting */
		public var pixelHinting:Boolean = false;
		
		/** scaleMode */
		public var scaleMode:String = 'normal';
		
		/** caps */
		public var caps:String;
		
		/** joints */
		public var joints:String;
		
		/** miterlimit */
		public var miterLimit:Number = 3;
	}

}