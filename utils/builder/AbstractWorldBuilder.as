package nextFramework.utils.builder 
{
	import flash.events.Event;
	import nextFramework.extension.sandy3d.factory.Shape3dFactory;
	import nextFramework.extension.sandy3d.parser.World3dParser;
	import nextFramework.nfRegistry;
	import nextFramework.utils.parser.IAssetParser;
	import nextFramework.xml.parser.IXmlParser;
	import nextFramework.utils.parser.IParserBuilder;
	import sandy.core.scenegraph.Group;
	import sandy.core.scenegraph.Shape3D;
	
	/**
	 * Abstract World Builder
	 * @author Darius Sobczak
	 */
	public class AbstractWorldBuilder implements IParserBuilder
	{
		private var _parser:IAssetParser;
		private var _group:Group;
		private var _assets:Array;
		public var onBuilded:Function = null;
		
		protected var _requiredClass:Class = Object;
		protected var _parserClass:Class = null;
		
		public function AbstractWorldBuilder() {
			this._assets = new Array();
		}
		
		/**
		 * load, parse a xml file and build this setting
		 * @param	url, url to xml file
		 * @param	onBuilded
		 */
		public function loadAndBuild(url:String, onBuilded:Function = null):void {
			var parser:* = new this._parserClass();
			if(parser is IAssetParser && parser is IXmlParser){
				(parser as IXmlParser).loadAndParse(url, this.parseComplete);
				this._parser = parser as IAssetParser;
				this.onBuilded = onBuilded;
			}else {
				throw new Error("Parser have to include the IAssetParser and IXmlParser Interface");
			}
		}

		/**
		 * create the object list
		 * 
		 * @param	conf
		 * @return	list what had been created
		 */
		public function build(conf:Object):Array {
			var createdList:Array = new Array;
			if (conf is Object) {
				if (!(conf is Array)) {
					conf = new Array(conf);
				}
				
				for each(var nodeConf:Object in conf) {
					var objectNode:Object = this.createObject(nodeConf);
					if (objectNode is this._requiredClass) {
						this.addObjectToAssets(objectNode);
						createdList.push(objectNode);
					}else {
						nfRegistry.addLog(this._requiredClass + " cannot build.", this);
					}
				}
			}
			return createdList;
		}
		
		/**
		 * abstract methode to create object
		 * @param	nodeConf
		 * @return
		 */
		protected function createObject(nodeConf:Object):Object { 
			throw new Error("createObject is a abstract methode, override it!");
		}
		
		/**
		 * can be override to extend this methode
		 * @param	node
		 * @return
		 */
		protected function addObjectToAssets(node:*):void {
			this._assets.push(node);
		}
		
		/**
		 * return asset by name
		 * @param	name
		 * @return
		 */
		public function getAssetByName(name:String):* {
			for each(var asset:* in this._assets) {
				if (asset.name == name) {
					return asset;
				}
			}
			return null;
		}
		
		/**
		 * return the created assets
		 */
		public function get assets():Array {
			return this._assets;
		}
		
		/**
		 * return the parser
		 */
		public function get parser():IAssetParser {
			return this._parser;
		}
		
		/**
		 * event calling after complete parsing
		 * @param	event
		 */
		private function parseComplete(event:Event):void{
			this.build(this._parser.assets);
			
			if (this.onBuilded is Function) {
				this.onBuilded(this);
			}
		}
	}

}