﻿package nextFramework.component 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import nextFramework.nF;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.component.*;
	import nextFramework.collection.IKeyValueNode;
	
	/**
	 * Main Component design class for nF
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfComponent extends EventDispatcher
	{
		/**
		 * singelton contructor
		 */
		function nfComponent() {
			if (!_canCreate) {
				throw new Error('nfComponent is a singelton class use the instance property');
			}
			
			this.addEventListener(Event.ENTER_FRAME, this.eventUpdateComponents);
			
		}
		static private var _instance:nfComponent = null;
		static private var _canCreate:Boolean = false;
		
		/**
		 * singelton property
		 * @return nfComponent
		 */
		static public function get instance():nfComponent {
			if (_instance == null) {
				nfComponent._canCreate = true;
				nfComponent._instance = new nfComponent;
				nfComponent._canCreate = false;
			}
			return nfComponent._instance;
		}
		
		/**
		 * extend nF Class with component methodes
		 * @return nfComponent
		 */
		static public function init():nfComponent {
			if (nfComponent._instance is nfComponent) return nfComponent.instance;
						
			//addComponent methode for nF
			nF.extend(
				'addComponent',
				function(comp:Class, conf:Object = null):nF {	
					var _this:nfComponent = nfComponent.instance;
					for each(var node:Object in this.selection) {
						var container:nfComponentObjectContainer = _this.getComponentContainer(node);
						
						//add the component
						if(container){
							container.addComponent(comp, conf);
						}
					}
					return this;
				}
			);
			
			//removeComponent methode for nF
			nF.extend(
				'removeComponent',
				function(comp:Class):nF {
					var _this:nfComponent = nfComponent.instance;
					
					for each(var node:Object in this.selection) {
						var container:nfComponentObjectContainer = _this.getComponentContainer(node);
						
						//add the component
						if(container){
							container.removeComponent(comp);
							if(!(node is IComponentContainer) && container.length < 1) {
								_this.collection.removeByKey(node);
							}
						}
					}
					return this;
				}
			);
			
			//hasComponent filter methode by selection
			nF.extend(
				'byComponent',
				function(comp:Class):nF {
					var _this:nfComponent = nfComponent.instance;
					var _selection:Vector.<Object> = new Vector.<Object>();
					
					for each(var node:Object in this.selection) {	
						var container:nfComponentObjectContainer;
						
						if (node is IComponentContainer) {
							container = (node as IComponentContainer).componentContainer;
						}else{
							var kvnode:IKeyValueNode = _this.collection.getNodeByKey(node);
							if (kvnode != null) {
								container = kvnode.value as nfComponentObjectContainer;
							}
						}
						
						if (container) {
							if (container.hasComponent(comp)) {
								_selection.push(container);
							}
						}
					}
					//update selection
					this.selection = _selection;
					return this;
				}
			);
			
			return nfComponent.instance;
		}
		
		 
		public function getComponentContainer(object:Object):nfComponentObjectContainer {
			var container:nfComponentObjectContainer;
						
			//first check interface
			if (object is IComponentContainer) {
				container = object.componentContainer as nfComponentObjectContainer;
			}else {
				//alternative global containers
				var kvnode:IKeyValueNode = this.collection.getNodeByKey(object);
				
				if (kvnode == null) {
					//create global container if not exists
					container = new nfComponentObjectContainer(object);
					this.collection.add(new nfKeyValueNode(object, container));
				}else {
					container = kvnode.value as nfComponentObjectContainer;
				}
			}
			
			return container;
		}
		
		// properties
		private var _collection:nfKeyValueCollection = new nfKeyValueCollection(true);
		public function get collection():nfKeyValueCollection {
			return this._collection;
		}
		
		
		
		private var _updateCollection:Vector.<Function> = new Vector.<Function>;
		public function get updateCollection():Vector.<Function> {
			return this._updateCollection;
		}
		public function registUpdateFunction(func:Function):nfComponent {
			this._updateCollection.push(func);
			return this;
		}
		public function unregistUpdateFunction(func:Function):nfComponent {
			var nList:Vector.<Function> = new Vector.<Function>;
			for each(var node:Function in this.updateCollection) {
				if (node != func) {
					nList.push(node);
				}
			}
			this._updateCollection = nList;
			return this;
		}
		
		//event
		private function eventUpdateComponents(event:Event):nfComponent {
			for each(var node:Function in this.updateCollection) {
				node();
			}
			return this;
		}
		
	}

}