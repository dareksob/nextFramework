package nextFramework.utils
{
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	public class nfTextField 
	{
		static public function addCssTextToObject(object:Object, text:String, stylesheet:String):void {
			nfTextField.addStyleToObject(object, stylesheet);
			nfTextField.addHtmlTextToObject(object, text);
		}
		
		static public function addTextToObject(object:Object, text:String):void {
			if (object.hasOwnProperty('text') && text) {
				object.text = text;
			}
		}
		static public function addHtmlTextToObject(object:Object, text:String):void {
			if (object.hasOwnProperty('htmlText') && text) {
				object.htmlText = text;
			}
		}
		
		static public function addStyleToObject(object:Object, stylesheet:String):void {
			if (object.hasOwnProperty('styleSheet') && stylesheet) {
				object.styleSheet = nfTextField.getStyleSheet(stylesheet);
			}
		}
		
		static public function getStyleSheet(stylesheet:String):StyleSheet {
			var sheet:StyleSheet = new StyleSheet();
			sheet.parseCSS(stylesheet);
			return sheet;
		}
		
	}

}