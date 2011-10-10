package nextFramework.flash 
{
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	import nextFramework.nfRegistry;
	import nextFramework.nfProperties;
	import flash.filters.*;
	
	/**
	 * filter manager for flash filters
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.03 beta
	 */
	 
	public class nfFlashFilter
	{
		
		public function addFilter(list:Vector.<Object>, filter:Object, conf:Object = null):nfFlashFilter {
			if (!conf) conf = { };
			
			for each(var node:Object in list) {
				// optional class or object
				var filterObject:* = filter;
				if(filter is Class){
					filterObject = new filter;
				}else {
					try {
						if (filter is String) {
							filterObject = new filter();
						}else {
							new Error('Filter couldn\'t initzialized. filter:'+filter.toString());
						}
					}catch (error:Error) {
						nfRegistry.addLog(error.message, this);
						return this;
					}
				}
				
				//shader
				if (filter is Shader) {
					filterObject = new ShaderFilter(filter as Shader);
				}

				if (node is DisplayObject) {
					var object:DisplayObject = node as DisplayObject;
					var filterList:Array = object.filters;
					var addFilterObject:Boolean = true;
					
					if (!conf.ignorIfExists || !conf.changeIfExists) {
						if (this.hasFilter(object, filter)) {
							if (conf.ignorIfExists) {
								//ignorIfExists
								addFilterObject = false;
							}else{
								//changeIfExists
								filterObject = this.getFilter(object, filter);
							}
						}
					}

					if (addFilterObject) {
						nfProperties.setObjectProperties(filterObject, conf, ['ignorIfExists', 'changeIfExists']);
						filterList.push(filterObject);
					}
					
					object.filters = filterList;
				}	
			}
			return this;
		}
		
		public function removeFilter(list:Vector.<Object>, filter:Object):nfFlashFilter {
		
			for each(var node:Object in list) {
				if (node is DisplayObject) {
					var displayobject:DisplayObject = node as DisplayObject;
					var filterList:Array = displayobject.filters;
					var nfilterList:Array = new Array();
					var filterobject:Object;
					
					if (filter is Class) {
						//get by class
						for each(filterobject in filterList) {
							if (!(filterobject is (filter as Class))) {
								nfilterList.push(filterobject);
							}
						}
					}else {
						//check by object
						for each(filterobject in filterList) {
							if (filterobject != filter) {
								nfilterList.push(filterobject);
							}
						}
					}
					displayobject.filters = nfilterList;
				}
			}
			return this;
		}
		
		public function changeFilter(list:Vector.<Object>, filter:Object, conf:Object):nfFlashFilter {
		
			for each(var node:Object in list) {
				if (node is DisplayObject) {
					var displayobject:DisplayObject = node as DisplayObject;
					var filterList:Array = displayobject.filters;
					
					for each(var filterobject:Object in filterList) {
						if (filter is Class) { 
							//set by class
							if (filterobject is (filter as Class)) {
								nfProperties.setObjectProperties(filterobject, conf);
							}
						}else {
							//set by object
							if (filterobject == filter) {
								nfProperties.setObjectProperties(filterobject, conf);
							}
						}
					}
					displayobject.filters = filterList;
				}
			}
			return this;
		}
		
		
		
		public function getFilter(object:Object, filter:Object):Object {
			if (object is DisplayObject) {
				var displayobject:DisplayObject = object as DisplayObject;
				var filterList:Array = displayobject.filters;
				var filterobject:Object;
				
				if (filter is Class) {
					//get by class
					for each(filterobject in filterList) {
						if (filterobject is (filter as Class)) {
							return filterobject;
						}
					}
				}else {
					//check by object
					for each(filterobject in filterList) {
						if (filterobject == filter) {
							return filterobject;
						}
					}
				}
			}
			return null;
		}
		
		public function hasFilter(object:Object, filter:Object):Boolean {
			var filter:Object = this.getFilter(object, filter);
			return filter != null;
		}
		
		static public function create():nfFlashFilter {
			return new nfFlashFilter();
		}
		
	}

}