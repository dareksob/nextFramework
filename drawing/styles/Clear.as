package nextFramework.drawing.styles
{
	import flash.display.Graphics;
	
	/**
	 * clear operation for clear the graphics
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 * @since 1.07
	 */
	
	public class Clear implements IStyle
	{
		function Clear(conf:Object = null):void {
		}
		public function setStyle(graphics:Graphics):void 
		{
			graphics.clear();
		}
		
	}

}