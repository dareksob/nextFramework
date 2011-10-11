package nextFramework.input 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public final class nfKeyMapping
	{
		private var _keymapList:Vector.<nfKeyMappingNode> = new Vector.<nfKeyMappingNode>();
		public function get keymapList():Vector.<nfKeyMappingNode> { 
			return this._keymapList; 
		}
		
		static public function getKeyCodeByEvent(event:Object, state:String):String {
			var keyCode:String = "";
			
			if (event is MouseEvent || event is KeyboardEvent) {

				/** todo keyboard location */
				var keyList:Array = new Array;
				if(event.shiftKey){
					keyList.push('shift');
				}
				if(event.altKey){
					keyList.push('alt');
				}
				if(event.ctrlKey){
					keyList.push('ctrl');
				}
				
				keyList.push(state);
				
				keyCode = keyList.join('+');
			}
			
			return keyCode;
		}
		
		public function callAllKeyMaps(keyValue:String, event:Event):nfKeyMapping {
			var list:Vector.<nfKeyMappingNode> = this.getKeyMapList(keyValue);
			for each(var keyNode:nfKeyMappingNode in list) {
				keyNode._event = event;
				keyNode.call();
			}
			return this;
		}
		
		public function addKeyMap(nodeOrKeyValue:Object, func:Function = null, userdata:* = null, removeIfExists:Boolean = false):nfKeyMapping {
			var node:nfKeyMappingNode = null;
			if (nodeOrKeyValue is nfKeyMappingNode) {
				node = nodeOrKeyValue as nfKeyMappingNode;
				nodeOrKeyValue = node.keyvalue;
				
			}else {
				node = new nfKeyMappingNode(nodeOrKeyValue as String, func, userdata);
			}
			
			if (removeIfExists) {
				this.removeKeyMap(nodeOrKeyValue as String);
			}
			
			this.keymapList.push(node);
			return this;
		}
		
		
		public function removeKeyMap(keyvalue:String):nfKeyMapping {
			var nList:Vector.<nfKeyMappingNode> = new Vector.<nfKeyMappingNode>();
			
			for each(var keyNode:nfKeyMappingNode in this.keymapList) {
				if (keyNode.keyvalue != keyvalue) {
					nList.push(keyNode);
				}
			}
			this._keymapList = nList;
			return this;
		}
		
		public function getKeyMapList(keyValue:String):Vector.<nfKeyMappingNode> {
			var rList:Vector.<nfKeyMappingNode> = new Vector.<nfKeyMappingNode>();
			for each(var keyNode:nfKeyMappingNode in this.keymapList) {
				if (keyNode.keyvalue == keyValue) {
					rList.push(keyNode);
				}
			}
			return rList;
		}
		
		public function getFirstKeyMap(keyValue:String):nfKeyMappingNode {
			var rList:Vector.<nfKeyMappingNode> = this.getKeyMapList(keyValue);
			if (rList.length > 0) {
				return rList[0];
			}
			return null;
		}
		
		public function hasKeyMap(keyValue:String):Boolean {
			var rList:Vector.<nfKeyMappingNode> = this.getKeyMapList(keyValue);
			if (rList.length > 0) {
				return true
			}
			return false;
		}
		
	}

}