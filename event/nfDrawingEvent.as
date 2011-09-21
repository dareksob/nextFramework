package nextFramework.event
{
	import flash.events.Event;
	import nextFramework.drawing.nfDrawing;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfDrawingEvent extends Event
	{
		
		function nfDrawingEvent(type:String, drawing:nfDrawing, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this._drawing = drawing;
		}
		static public function create(type:String, drawing:nfDrawing, bubbles:Boolean = false, cancelable:Boolean = false):nfDrawingEvent {
			return new nfDrawingEvent(type, drawing, bubbles, cancelable);
		}
		
		/*
		 * drawing
		 */
		private var _drawing:nfDrawing = null;
		public function get drawing():nfDrawing{ 
			return this._drawing; 
		}
		
	}

}