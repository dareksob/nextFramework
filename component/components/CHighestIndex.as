package nextFramework.component.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import nextFramework.component.nfComponentObject;
	import nextFramework.component.nfComponentObjectContainer;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class CHighestIndex extends nfComponentObject
	{
		
		public function CHighestIndex(container:nfComponentObjectContainer, object:Object, name:String = "") 
		{
			super(container, object, name);
		}
		
		override public function added():void {
			if (this.object is DisplayObject) {
				if (this.object.parent) {
					this.addedToStage(null);
				}else{
					(this.object as DisplayObject).addEventListener(Event.ADDED_TO_STAGE, addedToStage);
				}
			}
		}
		
		override public function removed():void 
		{
			if (this.object is DisplayObject) {
				if (this.object.parent) {
					this.removedFromParent();
					this.object.parent.removeChild(this.object);
				}
			}
		}
		
		private function removedFromParent():void 
		{
			if (this.object is DisplayObject) {
				if (this.object.parent) {
					(this.object.parent as DisplayObjectContainer).removeChild(this.object);
				}
			}
		}
		
		
		private function addedToStage(e):void {
			if (this.object.parent) {
				this.object.parent.addEventListener(Event.ADDED, addedChanged);
				this.changeIndex();
			}
		}
		private function addedChanged(e):void {
			if (this.object.parent) {
				changeIndex();
			}
		}
		
		private function changeIndex():void {
			if (this.object.parent) {
				this.object.parent.setChildIndex(this.object, this.object.parent.numChildren -1 );
			}
		}
		
		
	}

}