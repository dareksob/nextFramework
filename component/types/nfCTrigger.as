package nextFramework.component.types 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import nextFramework.component.*;
	import nextFramework.nF;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfCTrigger extends nfComponentObject
	{
		
		public function nfCTrigger(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			super(container, object, name);
		}
		override public function added():void 
		{
			this.addHandler(this.object as DisplayObject);
		}
		override public function removed():void 
		{
			this.removeHandler(this.object as DisplayObject);
		}
		private function addHandler(object:DisplayObject):void {
			nfComponent.instance.registUpdateFunction(this.updateTrigger);
		}
		private function removeHandler(object:DisplayObject):void {
			nfComponent.instance.unregistUpdateFunction(this.updateTrigger);
		}
		
		/*
		 * 
		 */
		private var _onCollition:Function;
		public function get onCollition():Function { 
			return this._onCollition; 
		}
		public function set onCollition(value:Function) {
			this._onCollition = value; 
		}
		
		
		private function updateTrigger():void {
			if (this.object is DisplayObject) {
				var displayobject:DisplayObject = this.object as DisplayObject;
				if (displayobject.parent is DisplayObjectContainer) {
					nF.create(displayobject.parent).getChilds(DisplayObject).each(this.checkCollition);
					
				}
			}
		}
		private function checkCollition(object:Object):void {
			var displayobject:DisplayObject = object as DisplayObject;
			var thisdisplayobject:DisplayObject = this.object as DisplayObject;
			
			if (displayobject == thisdisplayobject) return;
			
			if (thisdisplayobject.hitTestObject(displayobject)) {
				if (this.onCollition is Function) {
					this.onCollition(thisdisplayobject, displayobject);
				}
			}
		}
	}

}