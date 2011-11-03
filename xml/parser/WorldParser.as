package nextFramework.xml.parser 
{
	import flash.events.Event;
	import nextFramework.nfRegistry;
	import nextFramework.utils.nfObject;
	import nextFramework.utils.parser.IAssetParser;
	import nextFramework.utils.parser.NumberParser;
	import nextFramework.xml.parser.nfXML;
	import nextFramework.xml.parser.XMLObjectParser;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class WorldParser extends XMLObjectParser implements IAssetParser
	{
		protected var _libary:Object = { };
		protected var _assets:Array = new Array;
		protected var _objectKey:String = "object";
		
		public function get assets():Array {
			return this._assets;
		}
		
		public function get libary():Object {
			return this._libary;
		}
		
		override protected function startParse():void 
		{
			this.startParseLibary();
			this.startParseAssets();
			
			this.dispatchEvent(new Event(XMLObjectParser.EVENT_PARSECOMPLETE ));
		}
		
		/**
		 * parse for libary
		 */
		protected function startParseLibary():void {
			for each(var node:XML in this._xml.libary.node) {
				var name:String = node.@name.toString();
								
				//parse body
				if(name){
					var objectData:Object = {};
					
					var objectXml:XML = node[this._objectKey][0] as XML;
					if(objectXml is XML){
						objectData = this.parseXmlToObjectData(objectXml);
					}
					
					if(!this._libary[name]){
						this._libary[name] = objectData;
					}else{
						nfRegistry.addLog("Dublicate libaryname. "+name, this);
					}
				}
			}
		}
		
		/**
		 * startParseAssets
		 */
		protected function startParseAssets():void {
			for each(var node:XML in this._xml.assets.node) {

				var nodeConfig:Object = { 
					name: node.@name.toString() 
				};
				
				//set libary
				var libaryname:String = node.@libary.toString();
				if (libaryname) {
					if (this._libary[libaryname]) {
						nfObject.extend(nodeConfig, this._libary[libaryname], true);
					}else {
						nfRegistry.addLog("Libary object not found. " + libaryname, this);
					}
				}
				
				//set asset
				var objectXml:XML = node[this._objectKey][0] as XML;
				if(objectXml is XML){
					nfObject.extend(nodeConfig, this.parseXmlToObjectData(objectXml));
				}
				
				this.extendAndParseTranslate(nodeConfig, node);
				this.addAsset(nodeConfig);
			}
		}
		
		/**
		 * add nodeConfig ti asset list
		 * @param	nodeConfig
		 */
		protected function addAsset(nodeConfig:Object):void {
			this._assets.push(nodeConfig);
		}
		
		/**
		 * extend nodeConfig with translation
		 * @param	nodeConfig
		 * @param	node
		 */
		private function extendAndParseTranslate(nodeConfig:Object, node:XML):void {
			var translateXml:XML = node.translate[0] as XML;
			if(translateXml){
				nodeConfig["position"]	= this.parsePoint(translateXml.position[0]);
				nodeConfig["rotation"] 	= this.parsePoint(translateXml.rotation[0]);
				nodeConfig["scale"] 		= this.parsePoint(translateXml.scale[0], 1, 1, 1);
			}else {
				nodeConfig["position"]	= {x: 0, y: 0, z: 0};
				nodeConfig["rotation"] 	= {x: 0, y: 0, z: 0};
			}
		}
		
		/**
		 * parse XML to objectData
		 * @param	object
		 * @return
		 */
		protected function parseXmlToObjectData(objectXML:XML):Object {
			return nfXML.parseXmlToObject(objectXML);
		}
		
		protected function parsePoint(dataXML:XML, defaultX:Number = 0, defaultY:Number = 0, defaultZ:Number = 0):Object {
			if(dataXML){
				return {
					x: NumberParser.parse(dataXML.@x),
					y: NumberParser.parse(dataXML.@y),
					z: NumberParser.parse(dataXML.@z)
				};
			}
			return {x: defaultX, y: defaultY, z: defaultZ};
		}
	}

}