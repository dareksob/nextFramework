package nextFramework.drawing
{
	import flash.display.Graphics;
	import nextFramework.IExtension;
	import nextFramework.nF;
	
	/**
	 * nfDrawing plugin for nextFramework, this is the extention class
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public final class nfDrawing implements IExtension
	{
		
		/**
		 * extend the nF class with method draw
		 */
		static public function init():void {
			nF.extend(
				'draw', 
				function(conf:Object = null):nF {
					this.each(function(object:Object):void {

						if (object.hasOwnProperty('graphics')) {
							var graphics:Graphics = object['graphics'] as Graphics;
							if(graphics){
								
								var draw:nfDrawingOperator = new nfDrawingOperator(graphics, conf);
								draw.draw();
							}
						}
					});
					return this;
				}
			);
		}
		
	}

}