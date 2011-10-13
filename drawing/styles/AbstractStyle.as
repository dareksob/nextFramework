package nextFramework.drawing.styles
{
	import nextFramework.utils.nfObject;
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	internal class AbstractStyle
	{
		
		function AbstractStyle(conf:Object = null) 
		{
			nfObject.setProps(this, conf);
		}

		//color
		public var color:uint = 0;
		
		//alpha
		public var alpha:Number = 1;
	}

}