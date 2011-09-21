package nextFramework.loader
{
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	internal class nfLoaderClassCollection
	{
		/*
			loader Class List
		*/
		private var _loaderClassList:Vector.<nfLoaderClassNode> = new Vector.<nfLoaderClassNode>();
		internal function get loaderClassList():Vector.<nfLoaderClassNode> {
			return this._loaderClassList;
		}
				
		public function registLoaderClass(type:String, loaderClass:Class, priority:int):void {
			if(!this.hasLoaderClassTypeRegistered(type, loaderClass)){
				var classNode:nfLoaderClassNode = new nfLoaderClassNode();
					classNode.type = type;
					classNode.priority = priority;
					classNode.loaderClass = loaderClass;
					
				this._loaderClassList.push(classNode);
			}
		}
		
		public function getLoaderClassByType(type:String):ILoaderClass {
			var selLoaderClass:Class = null;
			for each(var loaderClass:nfLoaderClassNode in this.loaderClassList) {
				if (loaderClass.type == type) {
					if (selLoaderClass != null) {
						if (loaderClass.priority > selLoaderClass.priority) {
							selLoaderClass = loaderClass.loaderClass;
						}
					}else {
						selLoaderClass = loaderClass.loaderClass;
					}
				}
			}
			if(selLoaderClass != null){
				return new selLoaderClass;
			}
			return null;
		}
		
		public function hasLoaderClassRegistered(loaderClass:Class):Boolean {
			for each(var node:nfLoaderClassNode in this.loaderClassList) {
				if (node.loaderClass == loaderClass) {
					return true;
				}
			}
			return false;
		}
		public function hasLoaderTypeRegistered(type:String):Boolean {
			for each(var node:nfLoaderClassNode in this.loaderClassList) {
				if (node.type == type) {
					return true;
				}
			}
			return false;
		}
		
		public function hasLoaderClassTypeRegistered(type:String, loaderClass:Class):Boolean {
			return this.hasLoaderClassRegistered(loaderClass) && this.hasLoaderTypeRegistered(type);
		}
	}

}