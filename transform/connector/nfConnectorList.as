package nextFramework.transform.connector 
{
	import nextFramework.nfRegistry;
	/**
	 * Connection node for multi connections
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfConnectorList extends nfConnectorNodeAbstract 
	{
		private var _connectors:Vector.<IConnectorNode>;
		
		/**
		 * 
		 * @param	a array with IConnectionNodes
		 */
		public function nfConnectorList(conf:Object) 
		{
			_connectors = new Vector.<IConnectorNode>;
			this.addConnection(conf);
		}
		
		public function addConnection(conf:Object):void {
			if (conf) {
				if (conf is IConnectorNode) {
					_connectors.push(node as IConnectorNode);
				}else if (conf is Array) {
					for each(var node:Object in conf) {
						this.addConnection(node);
					}
				}else if (conf is Object) {
					try{
						var defaultClass:Class = conf.type ? conf.type : nfConnectorNode;
						var defaultChild:Object = conf.child;
						var defaultParent:Object = conf.parent;
						
						for(var prop:Object in conf.props) {
							var parentProp:String = conf.props[prop];
							//@NTH sup setting for class type
							var connector:IConnectorNode = new defaultClass(defaultChild, defaultParent, prop, parentProp);
							_connectors.push(connector);
						}
						
					}catch (error:Error) {
						nfRegistry.addLog(error.message, this);
					}
				}
			}
		}
		
		/**
		 * update the states
		 */
		public function update():void {
			if (!this._activate) return;
			
			if(this._connectors.length > 0){
				for each(var connector:IConnectorNode in this._connectors) {
					connector.update();
				}
			}
		}
	}

}