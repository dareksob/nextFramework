package nextFramework.transform.connector 
{
	import nextFramework.nfRegistry;
	import nextFramework.utils.rendering.nfRender;
	
	/**
	 * connector class to update all connectionnodes
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.08
	 */
	public class nfConnector 
	{
		private var _collection:Vector.<IConnectorNode>;
				
		/**
		 * add a new IConnectionNode object to the stack
		 * 
		 * @param	connector
		 * @return	nfConnector
		 */
		public function addConnection(connector:IConnectorNode, name:String = ""):nfConnector {
			this._collection.push(connector);
			
			if(name.length > 0){
				connector.name = name;
			}
			
			return this;
		}
		
		/**
		 * remove the connector
		 * @param	connector
		 * @return	true if has been found
		 */
		public function removeConnection(connector:IConnectorNode):Boolean {
			for (var index:String in this._collection) {
				if (this._collection[index] == connector) {
					return this.removeConnectionByIndex(uint(index));
				}
			}
			return false;
		}
		
		/**
		 * remove the connector by index
		 * @param	index
		 * @return	true if has been found
		 */
		public function removeConnectionByIndex(index:uint):Boolean {
			if (index < this._collection.length) {
				this._collection.splice(index, 1);
				return true;
			}
			return false;
		}
		
		/**
		 * upate for all connections
		 * @param	time
		 */
		private function update(time:Number):void {
			if(this._collection.length > 0){
				for each(var connector:IConnectorNode in this._collection) {
					try{
						connector.update();
					}catch (error:ReferenceError) {
						nfRegistry.addLog(error.message, this);
					}
				}
			}
		}
		
		/*
		 * singleton
		 */
		public function nfConnector(){
			if (!_canCreate) {
				throw new Error('nfConnector is a singelton class use the instance property');
			}
			this._collection = new Vector.<IConnectorNode>;
			
			//start updating
			nfRender.instance.addRender(this.update);
		}
		
		static private var _instance:nfConnector = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfConnector {
			if (_instance == null) {
				nfConnector._canCreate = true;
				nfConnector._instance = new nfConnector;
				nfConnector._canCreate = false;
			}
			return nfConnector._instance;
		}
	}

}