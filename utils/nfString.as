package nextFramework.utils 
{
	/**
	 * ...
	 * @author ...
	 */
	public class nfString 
	{
		
		/**
		 * convert first char to uppercase, optional lowercase all other
		 * @param	string
		 * @param	allLower
		 * @return	String
		 */
		public static function firstUpperCase(string:String, allLower:Boolean = false):String {
			if(string.length > 2){
				if (allLower) { string = string.toLowerCase(); }
				string = string.substr(0, 1).toUpperCase() + string.substr(1);
			}
			return string;
		}
		
	}

}