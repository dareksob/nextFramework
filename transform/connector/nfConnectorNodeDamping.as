package nextFramework.transform.connector 
{
	/**
	 * ConnectorNode for damped connection
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfConnectorNodeDamping extends nfConnectorNode 
	{
		protected var _damping:Number;
		
		public function nfConnectorNodeDamping(child:Object, parent:Object, childProp:String, parentProp:String="", damping:Number = 0.2) 
		{
			super(child, parent, childProp, parentProp);
			this._damping = damping;
		}
		
		override public function update():void {
			if (!this._activate) return;
			
			var distance:Number = this._parent[this._parentProp] - this._child[this._childProp] + this._offset;

			this._child[this._childProp] += (distance * _damping);
		}
		
	}

}