package nextFramework.drawing.style 
{
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.geom.Matrix;
	import nextFramework.nfProperties
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfShaderFillStyle implements IFillStyle
	{
		
		public function nfShaderFillStyle(conf:Object = null) 
		{
			nfProperties.setObjectProperties(this, conf);
		}
		
		public function beginFill(graphics:Graphics):void {
			
		}

		// Shader
		private var _shader:Shader;
		public function get shader():Shader { 
			return this._shader; 
		}
		public function set shader(value:Shader):void {
			this._shader = value; 
		}
		
		// Matrix
		private var _matrix:Matrix = new Matrix;
		public function get matrix():Matrix { 
			return this._matrix; 
		}
		public function set matrix(value:Matrix):void {
			this._matrix = value; 
		}
	}

}