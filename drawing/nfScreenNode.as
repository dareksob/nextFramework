package nextFramework.drawing 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import nextFramework.translate.ITranslate;
	import nextFramework.translate.nfTranslate;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfScreenNode implements ITranslate
	{
		internal var _bitmapData:BitmapData = null;
		internal var _parent:nfScreen = null;
		internal var _translate:nfTranslate = null;
		
		public var name:String = '';
		
		
		public function nfScreenNode(bitmapdata:BitmapData) 
		{
			this._bitmapData = bitmapdata;
			this._translate = new nfTranslate;
		}
		
		public function get bitmapData():BitmapData {
			return this._bitmapData;
		}
		
		public function get translate():nfTranslate {
			return this.translate;
		}
		public function set translate(value:nfTranslate):void {
			this.translate = value;
		}
		
	}

}