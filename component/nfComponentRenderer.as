package nextFramework.component 
{
	import flash.utils.Dictionary;
	import nextFramework.utils.rendering.nfRender;
	/**
	 * Rendering class for Component Objects
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class nfComponentRenderer 
	{
		private static var _list:Dictionary = new Dictionary;
		private static var _isInit:Boolean = false;
		
		public static function add(component:IUpdateComponentObject):void {
			nfComponentRenderer.init();
			if (component) {
				nfComponentRenderer._list[component] = component.update;
			}
			
		}
		public static function remove(component:IUpdateComponentObject):void {
			nfComponentRenderer.init();
			delete nfComponentRenderer._list[component];
		}
		
		private static function init():void {
			if (!nfComponentRenderer._isInit) {
				nfRender.instance.addRender(nfComponentRenderer.update);
				nfComponentRenderer._isInit = true;
			}
		}
		
		private static function update(time:Number):void {
			for each(var updateFunc:Function in nfComponentRenderer._list) {
				updateFunc(time);
			}
		}
		
		
		
	}

}