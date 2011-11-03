package nextFramework.utils 
{
	import flash.utils.*;
	import nextFramework.loader.IRessource;
	import nextFramework.nfRegistry;
	
	/**
	 * Create modfined class object
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	 
	public final class nfClass
	{		
		static public function getClass(classname:String, caller:* = null):Class {
			
			var ressources:IRessource = nfRegistry.instance.ressources as IRessource;
			
			if (ressources) {
				if (ressources.hasRessource(classname)) {
					return ressources.getRessource(classname) as Class
				}else {
					nfRegistry.addLog("Class "+classname+" not found.", caller);
				}
			}else {
				nfRegistry.addLog("Ressource class not defined.", nfClass);
			}
			
			return null;
		}
	}

}