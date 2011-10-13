package nextFramework.drawing 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import nextFramework.translate.nfSize;
	import nextFramework.translate.nfVector;
	import nextFramework.utils.rendering.IRenderUpdate;
	import nextFramework.utils.rendering.nfRender;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfScreen
	{
		protected var _cacheBitmap:BitmapData = null;
		protected var _graphics:Graphics = null;
		
		protected var _nodes:Vector.<nfScreenNode> = null;
		protected var _cacheNodes:Vector.<nfScreenNode> = null;
		
		private var _updateCache:Boolean = true;
		private var _backgroundColor:uint = uint.MAX_VALUE;
		
		private var _lastAddedNode:nfScreenNode = null;
		
		public var cutting:nfScreenCutting = null;
		
		public function nfScreen(graphics:Graphics, size:nfSize, cutting:nfSize, transparent:Boolean = false, backgroundColor:uint = uint.MAX_VALUE) 
		{
			this._graphics = graphics;
			this._backgroundColor = backgroundColor;
			this._cacheBitmap = new BitmapData(size.width, size.height, transparent, this._backgroundColor);
			
			this.cutting = new nfScreenCutting(cutting);
			
			this._nodes = new Vector.<nfScreenNode>();
			this._cacheNodes = new Vector.<nfScreenNode>();
		}
		
		/*
		 *  add nodes to renderlist
		 */
		public function addNode(node:nfScreenNode, cache:Boolean = false):nfScreen {
			node._parent = this;
			
			if (cache){
				this._cacheNodes.push(node);
				this._updateCache = true;
			}else {
				this._nodes.push(node);
			}
			this._lastAddedNode = node;

			return this;
		}
		
		
		/*
		 * return the last added Node
		 */
		public function get lastAddedNode():nfScreenNode {
			return this._lastAddedNode;
		}
		
		/*
		 * set background color and render cache again
		 */
		public function set backgroundColor(value:uint):void {
			this._backgroundColor = value;
			this._updateCache = true;
		}
		
		/*
		 * start rendering process
		 */
		public function startRender():nfScreen  {
			nfRender.instance.addRender(this.render);
			return this;
		}
		
		/*
		 * stop rendering process
		 */
		public function stopRender():nfScreen  {
			nfRender.instance.removeRender(this.render);
			return this;
		}

		
		/*
		 * rendering process
		 */
		public function render(time:Number):void {
			var smooth:Boolean = true;
			
			var node:nfScreenNode;

			
			/*
			 * render cache objects if it have to
			 */
			if (this._updateCache) {
				//fill clear color
				this._cacheBitmap.fillRect(new Rectangle(0, 0, _cacheBitmap.width, _cacheBitmap.height), this._backgroundColor);
				
				//render all nodes for cache
				for each(node in this._cacheNodes) {
					this._cacheBitmap.draw(node.bitmapData, node._translate.matrix);
				}

				this._updateCache = false;
			}
			
			/*
			 * create a new bitmap and render all elements from cache and dynamic nodes
			 */
			var display:BitmapData = new BitmapData(this.cutting.size.width, this.cutting.size.height, smooth, this._backgroundColor);
			
			//transform by scrolling
			var mat:Matrix = new Matrix;
			mat._translate(this.cutting.position.x, this.cutting.position.y);
			
			///draw cache
			display.draw(this._cacheBitmap, mat);
			
			/*
			 * render dynamic objects
			 */
			for each(node in this._nodes) {
				var matNode:Matrix = node._translate.matrix;
				matNode._translate(this.cutting.position.x, this.cutting.position.y);
				
				//update if have to
				if (node is IRenderUpdate) {
					(node as IRenderUpdate).renderUpdate(time);
				}
				
				display.draw(node.bitmapData, matNode);
			}
			
			//render bitmap on screen object
			this._graphics.clear();
			this._graphics.beginBitmapFill(display, null, false);
			this._graphics.drawRect(0, 0, this.cutting.size.width, this.cutting.size.height);
			this._graphics.endFill();
			
		}

		
	}

}