package nextFramework.component.factory 
{
	import nextFramework.component.IComponentContainer;
	import nextFramework.component.IComponentContainerObject;
	import nextFramework.loader.IRessource;
	import nextFramework.nfRegistry;
	
	/**
	 * Factory for dynamic creation and adding of Components,
	 * it use the IRessource Object
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class nfComponentsFactory 
	{
		private static var namespaces:Array = new Array(
			'nextFramework.component.components.'
		);
		
		/**
		 * regist a new component namespace,
		 * like 'nextFramework.component.components.'
		 * 
		 * @param	path
		 */
		public static function registNamespace(path:String):void {
			nfComponentsFactory.namespaces.push(path);
		}
		
		/**
		 * add components by conf object
		 * object have to be a IComponentContainer or IComponentContainerObject
		 * 
		 * @param	object
		 * @param	conf
		 */
		public static function addComponents(object:Object, conf:Object):void {
			
			if (conf) {
				if (object is IComponentContainer || object is IComponentContainerObject) {
					for (var compName:String in conf) {
						
						var compConf:Object = conf[compName];
						var compClass:Class = nfComponentsFactory.factory(compName);
						
						if(compClass is Class){
							if (object is IComponentContainer) {
								object.componentContainer.addComponent(compClass, compConf);
							}else {
								object.addComponent(compClass, compConf);
							}
						}else {
							nfRegistry.addLog("Class "+compName+" not found.", nfComponentsFactory);
						}
					}
				}else {
					nfRegistry.addLog("Object is not compatible, have to be IComponentContainer of IComponentContainerObject", nfComponentsFactory);
				}
			}
			
		}
		
		/**
		 * return a componentObject class
		 * 
		 * @param	type
		 * @return	Class
		 */
		public static function factory(type:String):Class {
			var ressources:IRessource = nfRegistry.instance.ressources;
			if(ressources is IRessource){
				for each(var nsp:String in nfComponentsFactory.namespaces) {
					var className:String = nsp + type;
					if (ressources.hasRessource(className)) {
						return ressources.getRessource(className) as Class;
					}
				}
			}else {
				nfRegistry.addLog("Ressource class not defined.", nfComponentsFactory);
			}
			return null;
		}
		
	}

}