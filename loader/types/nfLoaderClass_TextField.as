package nextFramework.loader.types
{
	import nextFramework.loader.*;
	import flash.net.*;
	import flash.events.*;
	import flash.display.*;
	import nextFramework.nfProperties;
	import nextFramework.utils.nfTextField;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfLoaderClass_TextField extends nfLoaderObject_Abstract implements ILoaderClass
	{
		function nfLoaderClass_TextField() { }
		
		static public function init():void {
			nfLoader.registLoaderClass('TextField', nfLoaderClass_TextField);
		}
		
		public function load():void
		{
			
			if (this.loaderNode.url is Array) {
				//first load text
				this._textUrl = this.loaderNode.url[0].toString();
				this._cssUrl = this.loaderNode.url[1].toString();
			}else {
				if (this.loaderNode.url is String) {
					//load by url text only
					this._textUrl = this.loaderNode.url.toString();
				}else if(this.loaderNode.url is Object){
					//load by object
					if (this.loaderNode.url.text is String) {
						this._textUrl = this.loaderNode.url.text.toString();
					}
					if (this.loaderNode.url.css is String) {
						this._cssUrl = this.loaderNode.url.css.toString();
					}
				}
			}
			if (this._textUrl) {
				nfLoader.instance.load('Text', this._textUrl, {onComplete: this.eventCompleteHandler});
			}
			if (this._cssUrl) {
				nfLoader.instance.load('Text', this._cssUrl, {onComplete: this.eventCompleteHandler});
			}
		}
		
		private var _textUrl:String;
		private var _cssUrl:String;
		
		override protected function eventCompleteHandler(event:Event):void 
		{
			var loaderEvent:nfLoaderEvent = event as nfLoaderEvent;
			this.addLoaderData(
				loaderEvent.loaderNode.object, 
				this.isLoaderDataTypeText(loaderEvent.loaderNode.url.toString())
			);

			if (this.isCompleteLoaded) {
				if (this.loaderNode.conf.textfield is Object) {
					
					
					nfTextField.addCssTextToObject(
						this.loaderNode.conf.textfield,
						this.loadedText,
						this.loadedCss
					);
				}
				super.eventCompleteHandler(event);
			}
		}
		
		private function get loadedText():String {
			if (this.loaderNode.object.text) {
				return this.loaderNode.object.text as String;
			}
			return this.loaderNode.conf.text as String;
		}
		
		private function get loadedCss():String {
			if (this.loaderNode.object.css) {
				return this.loaderNode.object.css  as String;
			}
			return this.loaderNode.conf.css as String;
		}
		
		private function addLoaderData(data:*, isText:Boolean = true):void {
			if (!this.loaderNode.object) {
				this.loaderNode.object = { css: null, text:null };
			}
			
			if (isText) {
				this.loaderNode.object.text = data;
			}else {
				this.loaderNode.object.css = data;
			}
		}
		
		private function get isCompleteLoaded():Boolean {
			return this.isTextLoaded && this.isCssLoaded;
		}
		
		private function get isTextLoaded():Boolean {
			if (!this._textUrl) {
				return !(this.loaderNode.object.text is Object);
			}
			return true;
		}
		
		private function get isCssLoaded():Boolean {
			if (!this._cssUrl) {
				return !(this.loaderNode.object.css is Object);
			}
			return true;
		}
		
		private function isLoaderDataTypeText(url:String):Boolean {
			if (url == this._textUrl) {
				return true;
			}
			return false;
		}
		
	}

}