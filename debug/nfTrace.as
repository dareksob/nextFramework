package nextFramework.debug 
{
	import nextFramework.utils.nfList;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	 
	public final class nfTrace
	{
		static public function traceProp(object:Object, inDepth:Boolean = true):void
		{
			trace(nfTrace.getPropString(object, inDepth));
		}
		
		static public function getArrayString(list:Array):String {
			var message:String = list+nfTrace.BREAK;
			for (var param:Object in list) {
				message += nfTrace.getBreakTabByLevel() + param + ':' + list[param];
			}
			return message;
		}
		
		static private var _level:uint = 1;
		static private const BREAK:String = '\n';
		static private const TAB:String = '\t';
		static private function getBreakTabByLevel():String {
			var str:String = nfTrace.BREAK;
			for (var level:uint = 0; level < nfTrace._level; level++) {
				str += nfTrace.TAB;
			}
			return str
		}
		
		static public function getPropString(object:Object, inDepth:Boolean = true):String
		{
			if (object == null) {
				return 'null';
			}
			
			var message:String = object.toString()+nfTrace.BREAK;
			for (var param:Object in object) {
				if (object[param] is Number || object[param] is String) {
					message += nfTrace.getBreakTabByLevel() + param + ':' + object[param];
				}else {
					if (inDepth) {
						nfTrace._level++;
						message += nfTrace.getBreakTabByLevel();
						message += nfTrace.getPropString(object[param], inDepth);
						nfTrace._level--;
					}else{
						message += nfTrace.getBreakTabByLevel() + param + ':' + object[param];
					}
				}
			}
			
			return message;
		}
		
	}

}