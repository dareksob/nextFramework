package nextFramework.display
{
	import flash.display.MovieClip;
	import nextFramework.component.IComponentContainer;
	import nextFramework.component.nfComponentObjectContainer;
	import nextFramework.component.types.nfCClipStopper;
	import nextFramework.component.types.nfCClicker;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	
	public class nfBanner extends MovieClip implements IComponentContainer
	{
	
		public function nfBanner() 
		{
			this._componentContainer = new nfComponentObjectContainer(this);
			
			//add componentes
			this.componentContainer.addComponent(nfCClipStopper);
			this.componentContainer.addComponent(nfCClicker);
			
			var clicker:nfCClicker = this.componentContainer.getComponent(nfCClicker) as nfCClicker;
			//external parameter
			if (root.loaderInfo.parameters && clicker is nfCClicker) {
				
				if (root.loaderInfo.parameters.clickURL is String) {
					clicker.url = root.loaderInfo.parameters.clickURL;
				}
				if (root.loaderInfo.parameters.clickCallJS is String) {
					clicker.callJS = root.loaderInfo.parameters.clickCallJS;
				}
				if (root.loaderInfo.parameters.clickWindow) {
					clicker.window = root.loaderInfo.parameters.clickWindow;
				}
			}
		}
		
		private var _componentContainer:nfComponentObjectContainer;
		public function get componentContainer():nfComponentObjectContainer {
			return this._componentContainer;
		}
		
		/*
		 * overide for compined control of time based break and default stop of movieclip
		 */
		override public function play():void 
		{
			var stopper:nfCClipStopper = (this._componentContainer.getComponent(nfCClipStopper) as nfCClipStopper);
			if(stopper.isStoppedByTime){
				(this._componentContainer.getComponent(nfCClipStopper) as nfCClipStopper).play();
			}else {
				super.play();
			}
		}
		
		/*
		 * stopByTime
		 */
		public function stopByTime(time:Number):nfBanner {
			(this._componentContainer.getComponent(nfCClipStopper) as nfCClipStopper).stopByTime(time);
			return this;
		}
		
		/*
		 * stopByTime
		 */
		public function clearTime():nfBanner {
			(this._componentContainer.getComponent(nfCClipStopper) as nfCClipStopper).clear();
			return this;
		}
		
		/*
		 * clickUrl
		 */
		public function set clickUrl(value:String):void {
			(this._componentContainer.getComponent(nfCClicker) as nfCClicker).url = value;
		}
		public function get clickUrl():String {
			return (this._componentContainer.getComponent(nfCClicker) as nfCClicker).url;
		}
		
		public function set clickWindow(value:String):void {
			(this._componentContainer.getComponent(nfCClicker) as nfCClicker).window = value;
		}
		public function get clickWindow():String {
			return (this._componentContainer.getComponent(nfCClicker) as nfCClicker).window;
		}
		
	}

}