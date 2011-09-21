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
		public var translate:nfTranslate = new nfTranslate;
		internal var _parent:nfScreen = null;
		public var name:String = '';
		
		public function nfScreenNode(bitmapdata:BitmapData) 
		{
			this._bitmapData = bitmapdata;
		}
		
		public function get bitmapData():BitmapData {
			return this._bitmapData;
		}		
	}

}