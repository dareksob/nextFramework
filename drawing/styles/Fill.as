package nextFramework.drawing.styles
{
	import flash.display.Graphics;
	import nextFramework.utils.nfObject;
	
	/**
	 * base fill style
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class Fill extends AbstractStyle implements IStyle
	{
		
		function Fill(conf:Object = null)
		{
			nfObject.setProps(this, conf);
		}
		
		public function setStyle(graphics:Graphics):void {
			graphics.beginFill(this.color, this.alpha);
		}
	}

}