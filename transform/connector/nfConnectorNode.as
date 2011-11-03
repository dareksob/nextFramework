package nextFramework.transform.connector 
{
	/**
	 * ConnectorNode object for update absolute, base Class
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfConnectorNode extends nfConnectorNodeAbstract
	{
		protected var _child:Object;
		protected var _parent:Object;
		protected var _childProp:String;
		protected var _parentProp:String;
		
		protected var _offset:Number = 0;
		
		public function nfConnectorNode(child:Object, parent:Object, childProp:String, parentProp:String = "") {
			this._child = child;
			this._childProp = childProp;
			this._parent = parent;
			this._parentProp = parentProp.length > 0 ? parentProp : childProp;
			
			_offset = this._child[this._childProp] -  this._parent[this._parentProp];
		}
		
		/**
		 * update state
		 */
		public function update():void {
			if (!this._activate) return;
			
			this._child[this._childProp] = this._parent[this._parentProp] + this._offset;
		}
		
		
		public function get offset():Number {
			return this._offset;
		}
		public function set offset(value:Number):void {
			this._offset = value;
		}
	}

}