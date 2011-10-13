package nextFramework.drawing.styles 
{
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.geom.Matrix;
	import nextFramework.utils.nfObject;
	
	/**
	 * fill style by shader
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class FillShader implements IStyle
	{
		
		public function FillShader(conf:Object = null) 
		{
			nfObject.setProps(this, conf);
		}
		
		public function setStyle(graphics:Graphics):void {
			graphics.beginShaderFill(this.shader, this.matrix);
		}

		/**
		 * Shader class
		 */ 
		public var shader:Shader;
		
		/**
		 * Matrix clas
		 */ 
		public var matrix:Matrix = new Matrix;
	}

}