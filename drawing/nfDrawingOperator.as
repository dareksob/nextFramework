package nextFramework.drawing 
{
	import flash.display.Graphics;
	import nextFramework.drawing.styles.IStyle;
	import nextFramework.utils.nfClass;
	import nextFramework.utils.nfObject;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfDrawingOperator
	{
		public var graphics:Graphics;
		private var _styles:Vector.<IStyle>;
		private var _adapters:Vector.<IDrawingAdapter>;
		
		public function nfDrawingOperator(graphics:Graphics, conf:Object) 
		{
			this.graphics = graphics;
			this._styles = new Vector.<IStyle>();
			this._adapters = new Vector.<IDrawingAdapter>();
			nfObject.setProps(this, conf);
		}
		
		/**
		 * start drawing
		 */
		public function draw():nfDrawingOperator {
			/**
			 * start style setup
			 */
			for each(var style:IStyle in this._styles) {
				style.setStyle(this.graphics);
			}
			
			
			/**
			 * start drawing operations
			 */
			for each(var adapter:IDrawingAdapter in this._adapters) {
				adapter.draw(this.graphics);
			}
			
			 this.graphics.endFill();
			
			return this;
		}
		
		/**
		 * return the style stack
		 * 
		 * @return Vector.<IStyle>
		 */
		public function getStyles():Vector.<IStyle> {
			return this._styles;
		}
		
		/**
		 *	add new IStyle 
		 * @param	style:IStyle
		 * @return	nfDrawingOperator
		 */
		public function addStyle(style:IStyle):nfDrawingOperator {
			this._styles.push(style);
			return this;
		}
		
		/**
		 * clear all styles in the stack
		 * @return	nfDrawingOperator
		 */
		public function clearStyles():nfDrawingOperator {
			this._styles = new Vector.<IStyle>();
			return this;
		}
		
		/** wrapped properties */
		public function set style(conf:Object):void {
			if (!(conf is Array)) {
				conf = new Array(conf);
			}
			
			for each(var style:Object in conf) {
				if (style is IStyle) {
					this._styles.push(style);
				}else {
					var styleClass:Object;
					
					//optional if its a class name
					if (style.type is String) {
						style.type = getDefinitionByName("nextFramework.drawing.styles." + style.type);
					}
					
					if (style.type is Class) {
						styleClass = new (style.type as Class);
					}
					
					if (styleClass is IStyle) {
						nfObject.setProps(styleClass, style); //set properties
						this._styles.push(styleClass);
					}
				}
			}
		}
		
		
		/**
		 * return the drawingAdapter stack
		 * 
		 * @return Vector.<IDrawingAdapter>
		 */
		public function getAdapters():Vector.<IDrawingAdapter> {
			return this._adapters;
		}
		
		/**
		 *	add new IDrawingAdapter 
		 * @param	adapter:IDrawingAdapter
		 * @return	nfDrawingOperator
		 */
		public function addAdapter(adapter:IDrawingAdapter):nfDrawingOperator {
			this._adapters.push(adapter);
			return this;
		}
		
		/**
		 * clear all adapters in the stack
		 * @return	nfDrawingOperator
		 */
		public function clearAdapter():nfDrawingOperator {
			this._adapters = new Vector.<IDrawingAdapter>();
			return this;
		}
		
		/** wrapped property for adapters */
		public function set adapter(conf:Object):void {
			if (!(conf is Array)) {
				conf = new Array(conf);
			}
			
			for each(var adapter:Object in conf) {
				if (adapter is IDrawingAdapter) {
					this._adapters.push(adapter);
				}else {
					var adapterClass:Object;
					
					//option if its a class name
					if (adapter.type is String) {
						adapter.type = getDefinitionByName("nextFramework.drawing.adapter." + adapter.type);
					}

					if (adapter.type is Class) {
						adapterClass = new (adapter.type as Class)(adapter);
					} 
					
					if (adapterClass is IDrawingAdapter) {
						nfObject.setProps(adapterClass, adapter); //set properties
						this._adapters.push(adapterClass);
					}else {
						throw new Error("Adapter class could not inisialize, type:"+adapter.type);
					}
				}
			}
		}
		
	}

}