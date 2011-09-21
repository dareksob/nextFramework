package nextFramework.debug 
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfTest
	{
		public function nfTest(name:String = "") 
		{
			this.name = name;
		}
		/*
		 * name
		 */
		private var _name:String = "";
		public function get name():String { 
			return this._name; 
		}
		public function set name(value:String) {
			this._name = value; 
		}
		
		
	}

}