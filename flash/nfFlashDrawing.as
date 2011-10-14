package nextFramework.flash 
{
	import flash.display.Graphics;
	import nextFramework.nfRegistry;
	
	/**
	 * drawing class for default flash operations
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.03 beta
	 * @created 11.02.2011
	 */
	public final class nfFlashDrawing
	{
		static public const DRAW_CIRCLE:String = 'circle';
		static public const DRAW_ELLIPSE:String = 'ellipse';
		static public const DRAW_RECT:String = 'rect';
		static public const DRAW_RECTROUND:String = 'rectRound';
		static public const DRAW_RECTROUNDCOMPLEX:String = 'rectRoundComplex';
		
		/**
		 * drawing method
		 * 
		 * @param	graphics:Graphics
		 * @param	conf:Object
		 */
		public function draw(graphics:Graphics, conf:Object):void {
			try {
				if (!(conf.x is Number)) conf.x = 0;
				if (!(conf.y is Number)) conf.y = 0;
				
				if (conf.position is Object) {
					if (conf.position['x'] is Number) { conf.x = conf.position.x; }
					if (conf.position['y'] is Number) { conf.y = conf.position.y; }
				}
				
				if (conf.offset is Object) {
					if (conf.offset.x is Number) { conf.x += conf.offset.x; }
					if (conf.offset.y is Number) { conf.y += conf.offset.y; }
				}
				
				
				var radius:Object;
				switch(conf.shape) {
					case DRAW_CIRCLE: 
							graphics.drawCircle(conf.x, conf.y, conf.radius);
						break;
						
					case DRAW_ELLIPSE: 
							graphics.drawEllipse(conf.x, conf.y, conf.width, conf.height);
						break;
						
					case DRAW_RECT: 
							graphics.drawRect(conf.x, conf.y, conf.width, conf.height);
						break;
						
					case DRAW_RECTROUND:
							radius = { width: 0, height: 0 };
							if (conf.radius is Object) {
								if (conf.radius.width is Number) { radius.width = conf.radius.width}
								if (conf.radius.height is Number) { radius.height = conf.radius.height }
							}
							if (conf.ellipseWidth is Number) radius.width = conf.ellipseWidth;
							if (conf.ellipseHeight is Number) radius.height = conf.ellipseHeight;
							
							graphics.drawRoundRect(conf.x, conf.y, conf.width, conf.height, radius.width, radius.height);
						break;
						
					case DRAW_RECTROUNDCOMPLEX:
							radius = { leftTop: 0, rightTop: 0, leftBottom: 0, rightBottom: 0};
							if (conf.radius is Object) {
								if (conf.radius.leftTop is Number) { radius.leftTop = conf.radius.leftTop }
								if (conf.radius.rightTop is Number) { radius.rightTop = conf.radius.rightTop }
								if (conf.radius.leftBottom is Number) { radius.leftBottom = conf.radius.leftBottom }
								if (conf.radius.rightBottom is Number) { radius.rightBottom = conf.radius.rightBottom }
							}else {
								if (conf.topLeftRadius is Number) { radius.leftTop = conf.topLeftRadius }
								if (conf.topRightRadius is Number) { radius.rightTop = conf.topRightRadius }
								if (conf.bottomLeftRadius is Number) { radius.leftBottom = conf.bottomLeftRadius }
								if (conf.bottomRightRadius is Number) { radius.rightBottom = conf.bottomRightRadius }
							}
							
							graphics.drawRoundRectComplex(conf.x, conf.y, conf.width, conf.height, 
								radius.leftTop, radius.rightTop, radius.leftBottom, radius.rightBottom);
						break;
					default: 
						nfRegistry.addLog('Drawing type not found: '+conf.type, this);
				}
			}catch (error:Error) {
				nfRegistry.addLog(error.message, this);
			}
		}
		
	}

}