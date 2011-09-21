package nextFramework
{
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 */
	public final class nfSort
	{
		static public const UP:String = 'up';
		static public const DOWN:String = 'down';
		
		private var orderParam:uint = Array.CASEINSENSITIVE;
		
		public function sort(list:Vector.<Object>, prop:String, order:String = 'up') {
			
			var propArray:Array = this.getPropArray(list, prop);;
			propArray.sortOn('prop', this.orderParam);
			list = this.getListOfPropArray(propArray);
			
			if (order == nfSort.DOWN) {
				list.reverse();
			}
			return list;
		}
		
		private function getPropArray(list:Vector.<Object>, prop:String):Array {
			var propList:Array = new Array();
			for each(var node:Object in list) {
				if(node.hasOwnProperty(prop)){
					propList.push( { prop: node[prop] , node: node } );
					
					//change param
					if (node[prop] is Number) {
						this.orderParam = Array.NUMERIC;
					}
				}else {
					propList.push( { prop: null, node: node } );
				}
			}
			return propList;
		}
		
		private function getListOfPropArray(array:Array):Vector.<Object> {
			var list:Vector.<Object> = new Vector.<Object>();
			for each(var prop:Object in array) {
				list.push(prop.node);
			}
			return list;
		}
	}

}