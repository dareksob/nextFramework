package nextFramework.drawing 
{
	import flash.display.Graphics;
	
	/**
	 * interface for drawing operations, like shapes
	 * 
	 * @author Darius Sobczak
	 */
	public interface IDrawingAdapter 
	{
		function draw(graphics:Graphics):void
	}
	
}