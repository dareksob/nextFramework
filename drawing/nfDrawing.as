package nextFramework.drawing
{
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.drawing.archetypes.*;
	import nextFramework.drawing.style.*;
	import flash.geom.Point;
	import nextFramework.flash.nfFlashDrawing;
	import nextFramework.nfProperties;
	import nextFramework.nF;
	import nextFramework.event.nfDrawingEvent;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06 beta
	 */
	 
	public final class nfDrawing
	{
		public static const EVENT_UPDATEDRAWING:String = 'UpdateDrawing';
		
		static public function init() {
			nF.extend(
				'draw', 
				function(conf:Object = null):nF {
					var nf:nF = nF.create(null).setSelection(this.selection, true);
					nf.each(function(object:Object) {

						if (object.hasOwnProperty('graphics')) {
							var drawing:nfDrawing;
							
							if (conf is Array) {
								for each(var confpart:Object in conf) {
									drawing = new nfDrawing(object.graphics, confpart);
									drawing.draw();
									
									if (conf && conf.onUpdate is Function) {
										object.addEventListener(Event.ENTER_FRAME, drawing.eventUpdate);
									}
								}
							}else{
								drawing = new nfDrawing(object.graphics, conf);
								drawing.draw();
									
								if (conf && conf.onUpdate is Function) {
									object.addEventListener(Event.ENTER_FRAME, drawing.eventUpdate);
								}
							}
							
						}
					});
					return this;
				}
			);
			
			//regist fillStyles
			nfDrawing._registFillStyleCollection.add(new nfKeyValueNode(null, nfFillStyle, true));
			nfDrawing._registFillStyleCollection.add(new nfKeyValueNode('Bitmap', nfBitmapFillStyle, true));
			nfDrawing._registFillStyleCollection.add(new nfKeyValueNode('Gradiant', nfGradiantFill, true));
			nfDrawing._registFillStyleCollection.add(new nfKeyValueNode('Shader', nfShaderFillStyle, true));
		}
		
		function nfDrawing(graphics:Graphics, conf:Object = null) {
			nfProperties.setObjectProperties(this, conf);
			this.graphics = graphics;
		}
		static public function create(graphics:Graphics, conf:Object = null):nfDrawing {
			return new nfDrawing(graphics, conf);
		}
		public function setProp(conf:Object):nfDrawing {
			nfProperties.setObjectProperties(this, conf);
			return this;
		}
		
		private function eventUpdate(event:Event):void {
			if (this.onUpdate is Function) {
				this.onUpdate(new nfDrawingEvent(nfDrawing.EVENT_UPDATEDRAWING, this));
			}
		}

		public function draw():void {
			this.updateDrawing();
		}
		
		protected function updateDrawing():void {
			if (!(this.graphics is Graphics)) return;
			
			if(this.clear){
				this.graphics.clear();
			}

			//style
			if (this.lineStyle) {
				this.lineStyle.setStyle(this.graphics);
			}
			if (this.fillStyle) {
				this.fillStyle.beginFill(this.graphics);
			}
			
			var drawdata:nfDrawingData;

			if (this.archetype) {
				drawdata = this.archetype.getCommandData();
			}else if (this.drawingData) {
				drawdata = this.drawingData;
			}
			
			if (drawdata) {
				drawdata.drawPath(this.graphics);
			}else if (this.flashDraw) {
				nfFlashDrawing.create().draw(this.graphics, this.flashDraw);
			}else {
				nfRegistry.addLog('No drawing data', this);
			}
			
			this.graphics.endFill();
		}
		
		private var _graphics:Graphics;
		public function get graphics():Graphics { return this._graphics; }
		public function set graphics(value:Graphics):void { this._graphics = value;	}
		
		private var _onUpdate:Function;
		public function get onUpdate():Function { return this._onUpdate; }
		public function set onUpdate(value:Function):void { this._onUpdate = value;	}
		
		private var _archetype:IArchetype;
		public function get archetype():IArchetype { return this._archetype; }
		public function set archetype(value:IArchetype):void { this._archetype = value;	}
		
		private var _drawingData:nfDrawingData;
		public function get drawingData():nfDrawingData { return this._drawingData; }
		public function set drawingData(value:nfDrawingData):void { this._drawingData = value;	}
		
		private var _flashDraw:Object;
		public function get flashDraw():Object { return this._flashDraw; }
		public function set flashDraw(value:Object):void { this._flashDraw = value;	}
		
		//line style
		private var _lineStyle:nfLineStyle;
		public function get lineStyle():nfLineStyle { return this._lineStyle; }
		public function set lineStyle( linetstyle:nfLineStyle ):void { this._lineStyle = linetstyle; }
		public function set setLineStyle(conf:Object):void {
			if (!this.lineStyle) {
				this.lineStyle = new nfLineStyle(conf);
			}else if(conf is Object){
				nfProperties.setObjectProperties(this.lineStyle, conf);
			}else {
				this.lineStyle = null;
			}
		}
		
		//fill style
		private var _fillStyle:IFillStyle;
		public function get fillStyle():IFillStyle { return this._fillStyle; }
		public function set fillStyle( value:IFillStyle ):void { 
			this._fillStyle = value; 
									trace(value);	
			}
		public function set setFillStyle(conf:Object):void {
			if (!this._fillStyle) {

				if (conf.type is Class) {
					this.fillStyle = new (conf.type as Class)(conf);
				}else{
					var keyNode:nfKeyValueNode = nfDrawing._registFillStyleCollection.getNodeByKey(conf.type);
					if (keyNode) {
						trace(keyNode.value.toString() + ' 1');	
						this.fillStyle = new (keyNode.value as Class)(conf);				
					}
				}
			}else if(conf is Object){
				nfProperties.setObjectProperties(this.fillStyle, conf);
			}
			this.fillStyle = null;
		}

		/*
		 * property
		 */
		private var _clear:Boolean = false;
		public function get clear():Boolean{ 
			return this._clear; 
		}
		public function set clear(value:Boolean):void {
			this._clear = value; 
		}
		
		//regist fillStyles
		static private var _registFillStyleCollection:nfKeyValueCollection = new nfKeyValueCollection(true);
		
		
	}

}