package nextFramework.translate 
{
	/**
	 * base class for 2d space
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfPoint
	{
		public var x:Number = 0;
		public var y:Number = 0;
		
		public function nfPoint(x:Number = 0, y:Number = 0) 
		{
			this.x = x;
			this.y = y;
		}
		
		public function toString():String {
			return "nfPoint x:" + this.x + " y:" + this.y;
		}
	}

}