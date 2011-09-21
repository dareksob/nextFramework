package nextFramework.utils 
{
	import adobe.utils.CustomActions;
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public class nfObject
	{
		//unusefull
		static public function clone(object:Object):Object {
			var nobject:Object = { };
			if (object is Object) {
				for (var prop:String in object) {
					nobject[prop] = object[prop];
				}
			}
			return nobject;
		}
		
		static public function addObject(object:Object, addobject:Object):Object {
			if (object == null) object = { };
			
			if (addobject is Object) {
				for (var prop:String in addobject) {
					object[prop] = addobject[prop];
				}
			}
			return object;
		}
		
		static public function func(object:Object, name:String, args:Array = null):Boolean {
			if(nfObject.hasFunc(object, name)){
				try {
					
					if(!(args is Array)) args = new Array();
					
					var func:Function = (object[name] as Function);
					if (func.length == args.length) {
						func.apply(object, args);
					}
				}catch (error:Error) { 
					nF.addLog(error.message, 'nfObject');
					return false; 
				}
			}
			return true;
		}
		
		static public function hasFunc(object:Object, name:String):Boolean {
			try {
				if (object[name] is Function) return true;
			}catch (error:ReferenceError) { }
			return false;
		}
	}

}