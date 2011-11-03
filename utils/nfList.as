package nextFramework.utils
{
	
	/**
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public final class nfList
	{
		
		static public function addToList(list:Object, fromList:Object):Object
		{
			//not really safely !!
			if(list != null && fromList != null){
				for each(var node:Object in fromList) {
					list.push(node);
				}
			}
			return list;
		}
		
		static public function toArray(iterable:Object):Array {
			if (iterable is Array) {
				return iterable as Array;
			}
			
			var array:Array = [];
			for each (var elem:* in iterable) array.push(elem);
			return array;
		}		
	}

}