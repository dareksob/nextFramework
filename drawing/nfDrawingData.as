package nextFramework.drawing
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.geom.Point;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public class nfDrawingData
	{				
		/**
		 * 
		 * @since	1.05b
		 * @param	conf
		 * @param	firstMove
		 */
		public function setLines(conf:Array, firstMove:Boolean = true):nfDrawingData {
			for (var i:int = 0; i < conf.length; i++ ) {
				var params:Object = conf[i];
				if (i == 0 && firstMove) {
					this.moveTo(params.x as Number, params.y as Number);
				}else {
					this.lineTo(params.x as Number, params.y as Number);
				}
			}
			return this;
		}
		
		public function curveTo(controlX:Number, controlY:Number, x:Number, y:Number):nfDrawingData {
			this.command.push(GraphicsPathCommand.CURVE_TO);
			this.data.push(controlX,controlY, x, y);
			return this;
		}
		
		public function moveTo(x:Number, y:Number):nfDrawingData {
			this.command.push(GraphicsPathCommand.MOVE_TO);
			this.data.push(x, y);
			return this;
		}
		
		public function lineTo(x:Number, y:Number):nfDrawingData  {
			this.command.push(GraphicsPathCommand.LINE_TO);
			this.data.push(x, y);
			return this;
		}
		
		public function close():nfDrawingData  {
			if (this.command[0] == GraphicsPathCommand.MOVE_TO) {
				this.lineTo(this.data[0], this.data[1]);
			}else {
				this.lineTo(0,0);
			}
			return this;
		}
		
		public function drawPath(graphics:Graphics, winding:String = 'evenOdd'):nfDrawingData  {
			graphics.drawPath(this.command, this.data, winding);
			return this;
		}
		
		
		/*
		 * commands
		 */
		private var _command:Vector.<int> = new Vector.<int>();
		public function get command():Vector.<int> { 
			return this._command; 
		}
		public function set command(value:Vector.<int>):void { 
			this._command = value;
		}
		
		/*
		 * data
		 */
		private var _data:Vector.<Number> = new Vector.<Number>();
		public function get data():Vector.<Number> { 
			return this._data; 
		}
		public function set data(value:Vector.<Number>):void { 
			this._data = value;
		}
		
		/*
		 * 
		 * 	methodes
		 */
		
		public function get length():int {
			return this.command.length;
		}
		
		public function add(command:int, data:Number):nfDrawingData {
			this.command.push(command);
			this.data.push(data);
			return this;
		}
		public function merge(drawingdata:nfDrawingData):nfDrawingData {
			this.command.push(drawingdata.command);
			this.data.push(drawingdata.data);
			return this;
		}
		
		public function remove(startIndex:int, endIndex:int):nfDrawingData {
			this.command = this.command.slice(startIndex, endIndex);
			this.data = data.slice(startIndex, endIndex);
			return this;
		}
		
		public function reverse():nfDrawingData {
			this.command = this.command.reverse();
			this.data = this.data.reverse();
			return this;
		}
		
		public function copy():nfDrawingData {
			var copy:nfDrawingData = new nfDrawingData;
			for each(var command:int in this.command){
				copy.command.push(command);
			}
			for each(var data:Number in this.data){
				copy.data.push(data);
			}
			return copy;
		}
		
		//static creating methodes
		static public function create():nfDrawingData {
			return new nfDrawingData;
		}
		
		static public function createLine(point1:Point, point2:Point):nfDrawingData {
			var _this:nfDrawingData = new nfDrawingData();
			return _this.moveTo(point1.x, point1.y).lineTo(point2.x, point2.y);
		}
	}

}