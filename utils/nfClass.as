package nextFramework.utils 
{
	import flash.utils.*;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public final class nfClass
	{
		static public function clone(object:Object):*{
			var clone:* = null;
			if (object is Object) {
				//copy class
				try{
					var classObject:Class = nfClass.getClass(object);
					clone = new classObject();
				}catch (error:Error) {
					nF.addLog(error.message, new nfClass);
				}
				
				//data
				if (clone is Object) {
					nfProperties.setObjectProperties(object, clone);
				}
			}
			
			return clone;
		}
		static public function getClass(object:Object):Class {
			return getDefinitionByName(getQualifiedSuperclassName(object)) as Class;
		}
		
		static public function getClassByName(classname:String, removespace:Boolean = true):Class
		{
			//remove space
			if (removespace) {
				classname = classname.split(" ").join("");
			}
			
			if(classname.indexOf('.') == -1){
				var classobject:Class = nfClass.getDefaultClasses(classname);
				if (classobject) {
					return classobject;
				}
			}
			
			//last test
			try{
				return getDefinitionByName(classname) as Class;
			}catch (error:Error) {
				nF.addLog(error, 'nfClass');
			}

			return null;
		}
		
		
		static public function getDefaultClasses(classname:String):Class
		{
			var classobject:Class;
			for each(var ns:String in nfClass.namespaceList) {
				try {
					classobject = getDefinitionByName(ns+classname) as Class;
				}catch(error:Error){ }
			}
			
			return classobject;
		}
		
		static private var namespaceList:Array = [
			'flash.display.',
			'flash.text.',
			'flash.text.engine.'
		];
		
		static public function registNamespace(ns:String):void {
			nfClass.namespaceList.push(ns);
		}
		
		
		
	}

}