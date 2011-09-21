package nextFramework.drawing 
{
	import flash.geom.Rectangle;
	import nextFramework.translate.nfSize;
	import nextFramework.translate.nfVector;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public final class nfScreenCutting
	{
		public var position:nfVector = null;
		public var size:nfSize = null;
		
		public function nfScreenCutting(size:nfSize = null, position:nfVector = null) 
		{
			this.position = position ? position : new nfVector;
			this.size = size ? size : new nfSize;
		}
		
		public function get rectangle():Rectangle {
			return new Rectangle(this.position.x, this.position.y, this.size.width, this.size.height);
		}
	}

}