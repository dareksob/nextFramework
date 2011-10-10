package nextFramework 
{
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	import flash.utils.getQualifiedClassName;
	import nextFramework.flash.nfFlashShader;
	import nextFramework.flash.nfFlashObject;
	import nextFramework.nfRegistry;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public class nfProperties
	{
		
		static public function setListProperties(list:Vector.<Object>, conf:Object, ignorProperties:Array = null):Vector.<Object>
		{
			for each(var node:Object in list) {
				nfProperties.setObjectProperties(node, conf, ignorProperties);
			}
			return list;
		}
		
		static public function setObjectProperties(object:*, conf:Object, ignorProperties:Array = null):Object {
			try{
				for (var prop:String in conf) {
					if(object.hasOwnProperty(prop)){
						if (!nfProperties.isIgnorProperty(prop, ignorProperties)) {
							try {
								if (object[prop] is Object &&
									getQualifiedClassName(conf[prop]) == 'Object'
								) {
									object[prop] = nfProperties.setObjectProperties(object[prop], conf[prop]);
								}else {
									object[prop] = conf[prop];
								}
							}catch (error:Error) {
								object[prop] = conf[prop];
							}
						}
					}else if (object is ShaderFilter) {
						nfFlashShader.create().setParameter(object.shader as Shader, conf);
					}else if (object is Shader) {
						nfFlashShader.create().setParameter(object as Shader, conf);
					}else {
						nfProperties.setExtraProperties(object, prop, conf[prop]);
					}
				}
			}catch (error:Error) {
				nfRegistry.addLog(error.message, object);
			}
			return object;
		}

		//return a new list of object, what have the property
		static public function getListByProperty(list:Vector.<Object>, property:String):Vector.<Object> {
			var nlist:Vector.<Object> = new Vector.<Object>();
			for each(var node:Object in list) {
				if (node.hasOwnProperty(property)) {
					nlist.push(node);
				}
			}
			return nlist;
		}
		
		static private function isIgnorProperty(prop:String, ignorProperties:Array):Boolean {
			if (ignorProperties is Array) {
				for each(var iprop:String in ignorProperties) {
					if (prop == iprop) {
						return true;
					}
				}
			}
			return false;
		}
		
		
		static private function setExtraProperties(object:Object, prop:Object, value:Object):void {
			switch(prop) {
				case 'index':
						nfFlashObject.create().setIndex(object, value);
					break;
			}
		}
		
		
	}

}