package nextFramework.utils 
{
	import flash.utils.ByteArray;
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
		 * deep objects copy
		 * 
		 * @param	object
		 * @return	*
		 */
		static public function clone(object:Object):* {
			var data:ByteArray = new ByteArray();
			data.writeObject(object);
			data.position = 0;
			return data.readObject();
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
			var result:Boolean = true;
			for (var prop:String in conf) {
				if(object.hasOwnProperty(prop)){
					object[prop] = conf[prop];
				}else{
					result = false;
				}
			}
			return result;
		}
		
		/**
		 * extends the object by ther object
		 * 
		 * @param	object
		 * @param	conf
		 * @param	deepCopy, default false
		 * @return	Object
		 */
		static public function extend(object:Object, conf:Object, deepCopy:Boolean = false):Object {
			var copyObject:Object = deepCopy ? nfObject.clone(conf) : conf;
			for (var prop:String in copyObject) {
				object[prop] = copyObject[prop];
			}
			return object;
		}
		
		
		static public function setPropsByDefault(object:Object, conf:Object, propList:Array):void {
			for each(var prop:String in propList) {
				if (conf.hasOwnProperty(prop)) {
					if(!object.hasOwnProperty(prop)){
						object[prop] = conf[prop];
					}else if(object[prop] == null || isNaN(object[prop])){
						object[prop] = conf[prop];
					}
					
				}
			}
		}
		
	}

}