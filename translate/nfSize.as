package nextFramework.translate 
{
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfSize
	{
		public var width:Number = 0;
		public var height:Number = 0;
		
		public function nfSize(width:Number = 0, height:Number = 0) 
		{
			this.width = width;
			this.height = height;
		}
		
		//return this as string
		public function toString():String {
			return '[nfSize] width:' + width + ' height:' + height;
		}
	}

}