package nextFramework.translate 
{
	/**
	 * body object for size defininition in 2d space
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
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
		
		/**
		 * set properties by configuration object or similar
		 * @param	conf
		 * @return
		 */
		public function setOptions(conf:Object):nfSize {
			if (conf) {
				if (conf.hasOwnProperty("width") && conf.width is Number) {
					this.width = Number(conf.width);
				}
				if (conf.hasOwnProperty("height") && conf.height is Number) {
					this.width = Number(conf.height);
				}
			}
			return this;
		}
		
		public function getByAxis(axis:String):Number {
			switch(axis) {
				case "x": return this.width;
				case "y": return this.height;
			}
			return 0;
		}
		
		//return this as string
		public function toString():String {
			return '[nfSize] width:' + width + ' height:' + height;
		}
	}

}