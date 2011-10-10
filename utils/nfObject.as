package nextFramework.utils 
{
	import nextFramework.nfRegistry;
	
	/**
	 * helper class for modifications of objects
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	public class nfObject
	{
		/**
		 * make a copy of a object, only useble for stdObjects
		 * 
		 * @param	object
		 * @return	Object, new clone object
		 */
		static public function clone(object:Object):Object {
			var nobject:Object = { };
			if (object is Object) {
				for (var prop:String in object) {
					nobject[prop] = object[prop];
				}
			}
			return nobject;
		}
		
		/**
		 * merge to object to getter like copy to
		 * @param	object, can be null.
		 * @param	addobject
		 * @return	Object
		 */
		static public function merge(object:Object, addobject:Object):Object {
			if (object == null) object = { };
			
			if (addobject is Object) {
				for (var prop:String in addobject) {
					object[prop] = addobject[prop];
				}
			}
			return object;
		}
		
		/**
		 * call a methode of this object
		 * 
		 * @param	object
		 * @param	name, function name
		 * @param	args, arguments for this
		 * @return	true if its could call also false
		 */
		static public function func(object:Object, name:String, args:Array = null):Boolean {
			if(nfObject.hasFunc(object, name)){
				try {
					
					if(!(args is Array)) args = new Array();
					
					var func:Function = (object[name] as Function);
					if (func.length == args.length) {
						func.apply(object, args);
					}
					
					return true; 
					
				}catch (error:Error) { 
					nfRegistry.addLog(error.message, 'nfObject');
					return false; 
				}
			}
			return false; 
		}
		
		/**
		 * has a function
		 * @param	object
		 * @param	name, functionname
		 * @return	boolean
		 */
		
		static public function hasFunc(object:Object, name:String):Boolean {
			try {
				if (object[name] is Function) return true;
			}catch (error:ReferenceError) { }
			return false;
		}
		
		/**
		 * simple methode for setting a object by configuration object
		 * @param	object
		 * @param	conf
		 * @return	true if its was successful, false if not
		 */
		static public function setProps(object:Object, conf:Object):Boolean {
			for (var prop:String in conf) {
				if(object.hasOwnProperty(prop)){
					try {
						object[prop] = conf[prop];
					}catch (error:Error) {
						return false;
					}
				}
			}
			return true;
		}
	}

}