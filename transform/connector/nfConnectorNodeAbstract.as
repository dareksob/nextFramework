package nextFramework.transform.connector 
{
	/**
	 * Abstract nfConnectorNode
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfConnectorNodeAbstract implements IConnectorNode
	{
		protected var _name:String = "";
		protected var _activate:Boolean = true;
		
		public function update():void {
			throw new UninitializedError("nfConnectorNodeAbstract.update() have to override. Its Abstract");
		}
		
		/**
		 * return the name
		 */
		public function get name():String {
			return this._name;
		}
		/**
		 * set the name
		 */
		public function set name(value:String):void {
			this._name = value;
		}
		
		public function set activate(value:Boolean):void {
			this._activate = value;
		}
		public function get activate():Boolean {
			return this._activate;
		}
		
		public function get isActivate():Boolean {
			return this._activate;
		}
		
	}

}