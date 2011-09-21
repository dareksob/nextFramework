package nextFramework 
{
	import flash.display.*;
	import nextFramework.utils.nfClass;
	import nextFramework.utils.nfList;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.01 beta
	 */
	 
	internal final class nfSelection
	{
		
		public function getChilds(root:Object, conf:Object = null):Vector.<Object> {
			var list:Vector.<Object> = new Vector.<Object>();
			
			if (root is DisplayObjectContainer) {
				list = this.loadChilds(root as DisplayObjectContainer);
				list = this.filter(list, conf);
			}
			return list;
		}
		
		public function not(list:Vector.<Object>, conf:Object):Vector.<Object> {
			var notlist:Vector.<Object> = this.filter(list, conf);
			var nlist:Vector.<Object> = new Vector.<Object>();
			
			for each(var node:Object in list) {
				var isAllowed:Boolean = true;
				for each(var notnode:Object in notlist) {
					if (notnode == node) {
						isAllowed = false;
						break;
					}
				}
				if (isAllowed) {
					nlist.push(node);
				}
			}
			return this.makeListUnique(nlist);
		}
		
		
		//filter this list by conf
		public function filter(list:Vector.<Object>, conf:Object):Vector.<Object> {
			if (conf is Object) {
				
				if (conf is Class) {
					//class filter
					list = this.filterByClass(conf as Class, list);
				}else if (conf is Array) {
					//class array filter
					list = this.filterByArray(conf as Array, list);
				}else if (conf is String) {
					//css filter
					list = this.filterByString(conf as String, list);
				}
				
			}
			return this.makeListUnique(list);
		}
		
		private function filterByClass(conf:Class, list:Vector.<Object>, nlist:Vector.<Object> = null):Vector.<Object> {
			if(!nlist) nlist = new Vector.<Object>();
			for each(var node:Object in list) {
				if (node is conf) {
					nlist.push(node);
				}
			}
			return nlist;
		}
		
		private function filterByArray(conf:Array, list:Vector.<Object>):Vector.<Object> {
			var nlist:Vector.<Object> = new Vector.<Object>();
			for each(var node:Object in conf) {
				this.filterByClass(node as Class, list, nlist);
			}
			
			return nlist;
		}
		
		private function filterByString(conf:String, list:Vector.<Object>):Vector.<Object> {
			var nlist:Vector.<Object> = new Vector.<Object>();
			
			var parameters:Array = conf.split(',');
			for each(var param:String in parameters) {
				var levelList:Array = param.split('>');
				
				this.loadByString(levelList[0], nlist, list);
				
				if(levelList.length > 1){
					var depthList:Vector.<Object> = nfList.addToList(new Vector.<Object>, nlist) as Vector.<Object>;
						
					for (var level:int = 1; level < levelList.length; level++) {
						var depthQuery:String = levelList[level];
						var depthTempList:Vector.<Object> = new Vector.<Object>();
						for each(var node:Object in depthList) {
							var temp:Vector.<Object> = nF.create(node).getChilds(depthQuery).selection
							nfList.addToList(depthTempList, temp);
						}
						depthList = depthTempList;
					}
					nlist = depthList;
				}
			}
			
			return nlist;
		}
		
		private function loadByString(conf:String, addlist:Vector.<Object>, list:Vector.<Object>):void {

			var prop:Array = conf.split('#');
			var classname:String = '';
			var objectname:String = '';
			
			/*
			 * MovieClip#Name or
			 * #Name or
			 * MovieClip
			 */
			
			if (prop.length > 1) {
				if (prop[0] == '') {
					//#Name
					objectname = prop[1];
				}else {
					//MovieClip#Name
					classname = prop[0];
					objectname = prop[1];
				}
			}else {
				//MovieClip
				classname = prop[0];
			}
			
			//get class
			var classobject:Class;
			if(classname){
				classobject = nfClass.getClassByName(classname, true);
			}
			
			//clean name
			objectname = objectname.split(' ').join('');
			
			//start filtering
			for each(var node:Object in list) {
				var isClass:Boolean = true;
				if (classobject) {
					if (!(node is classobject)) {
						isClass = false;
					}
				}
				var isName:Boolean = true;
				if (node is DisplayObject) {
					if (objectname != '') {
						if (!((node as DisplayObject).name == objectname)) {
							isName = false;
						}
					}
				}
				if (isClass && isName) {
					addlist.push(node);
				}
			}
		}		
		
		
		private function makeListUnique(list:Vector.<Object>):Vector.<Object> {
			var nlist:Vector.<Object> = new Vector.<Object>();
			for each(var node:Object in list) {
				var found:Boolean = false;
				for each(var nNode:Object in nlist) {
					if (node == nNode) {
						found = true;
						break;
					}
				}
				if(!found){
					nlist.push(node);
				}
			}

			return nlist;
		}
		
		
		//load all elements of root
		private function loadChilds(root:DisplayObjectContainer):Vector.<Object> {
			var list:Vector.<Object> = new Vector.<Object>();
			for (var index:int = 0; index < root.numChildren; index++) {
				list.push(root.getChildAt(index));
			}
			return list;
		}
		
	}

}