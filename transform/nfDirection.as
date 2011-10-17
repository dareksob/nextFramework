package nextFramework.transform 
{
	
	/**
	 * Enumeration class for direction x, y or xy;
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public final class nfDirection
	{
		
		/*
		 * direction const
		 */
		public static const X:String = 'x';
		public static const Y:String = 'y';
		public static const XY:String = 'xy';
		
		/**
		 * helper method to set the right value
		 * 
		 * @param	value
		 * @param	bothAllowed, if XY is allowed
		 * @return	String
		 */
		static public function getValue(value:Object, bothAllowed:Boolean = true):String {
			switch(value) {
				case XY:
					if(bothAllowed){
						return XY; 
					}
				case Y:
					return Y;				
			}
			return "x";
		}
	}

}