package nextFramework.drawing.style 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import nextFramework.drawing.style.nfFillStyle;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import nextFramework.event.nfLoaderEvent;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfBitmapFillStyle implements IFillStyle
	{
		
		public function nfBitmapFillStyle(conf:Object = null) 
		{
			nfProperties.setObjectProperties(this, conf, ['load']);
			if (conf) {
				if (conf.load is String) {
					nF.create(this).load('DisplayObject', conf.load as String, { onComplete: this.eventLoadedBitmap } );
				}
			}
		}
		public function beginFill(graphics:Graphics):void {
			if(this.bitmapData){
				graphics.beginBitmapFill(this.bitmapData as BitmapData, this.matrix, this.repeat, this.smooth);
			}
		}
		
		private var _drawUpdate:Function;
		public function set drawUpdate(value:Function):void {
			this._drawUpdate = value;
		}
		
		private function eventLoadedBitmap(event:nfLoaderEvent) {
			if (event.loaderNode.object is Bitmap) {
				this.bitmapData = event.loaderNode.object;
				if (this._drawUpdate is Function) {
					this._drawUpdate();
				}
			}
		}
		
		
		// BitmapData
		private var _bitmapData:Object;
		public function get bitmapData():Object { 
			return this._bitmapData; 
		}
		public function set bitmapData(value:Object):void {
			if(value is BitmapData){
				this._bitmapData = value; 
			}else if (value is Bitmap) {
				this._bitmapData = (value as Bitmap).bitmapData;
			}
		}
		
		// Matrix
		private var _matrix:Matrix = new Matrix;
		public function get matrix():Matrix { 
			return this._matrix; 
		}
		public function set matrix(value:Matrix):void {
			this._matrix = value; 
		}
		
		// Repeat
		private var _repeat:Boolean = true;
		public function get repeat():Boolean { 
			return this._repeat; 
		}
		public function set repeat(value:Boolean):void {
			this._repeat = value; 
		}
		
		// Smooth
		private var _smooth:Boolean = false
		public function get smooth():Boolean { 
			return this._smooth; 
		}
		public function set smooth(value:Boolean):void {
			this._smooth = value; 
		}
		
	}

}