package nextFramework.animation
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import nextFramework.nF;
	import nextFramework.nfProperties;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	 
	public class nfAnimationNode implements IAnimationObject
	{
		private var _isStarted:Boolean = false;	
		public function get isStarted():Boolean {
			return this._isStarted;
		}
		private var _startOnComplete:Function;	
		
		public function start(onComplete:Function = null):IAnimationObject {
			if (!this.isStarted) {
				this._isStarted = true;
				this._startOnComplete = onComplete;
				
				if(this.prop.length == 0){
					this.eventMotionFinish(null);
				}else{
					this.startAnimation();
				}
			}
			return this;
		}
		
		public function stopAll():nfAnimationNode {
			for each(var tween:Tween in this._tweens) {
				if (tween.isPlaying) {
					tween.stop();
				}
			}
			return this;
		}
		
		private var _tweens:Vector.<Tween> = new Vector.<Tween>();
		private function startAnimation():void {
			var tween:Tween;
			for (var index:String in this.prop) {
				var aniParam:Object = this.prop[index];
				var propname:String = aniParam.prop;

				if (this.object.hasOwnProperty(propname)) {
					var propvalue:Object = aniParam.finish;
					var propbegin:Number = this.getBegin(propname);
					var propfinish:Number = this.getFinish(propname, propvalue);
					
					//revers
					if (this.revers) {
						var tmp:Number = propfinish;
						propfinish = propbegin;
						propbegin = tmp;
					}

					tween = new Tween( 
						this.object, 
						propname,
						this.transition, 
						propbegin, 
						propfinish, 
						this.getTime(),
						this.useSeconds
					);
					this.start();
				}
			}
			if(tween is Tween){
				tween.addEventListener(TweenEvent.MOTION_FINISH, this.eventMotionFinish);
				this._tweens.push(tween);
			}else {
				this.eventMotionFinish(null);
			}
		}

		private function eventMotionFinish(event:TweenEvent):void {
			if (this._startOnComplete is Function) {
				this._startOnComplete(this);
			}
			if (this.onComplete is Function) {
				this.onComplete(this);
			}
		}
		
		/*
		 constructor
		*/
		
		static private var _canCreate:Boolean = false;
		function nfAnimationNode(object:Object, conf:Object) {
			if (!nfAnimationNode._canCreate) {
				throw "nfAnimationNode you can't create this class direct. Use static methode create.";
			}
			
			this.object = object;
			nfProperties.setObjectProperties(this, conf);
		}
		
		static public function create(object:Object, conf:Object):nfAnimationNode {
			var propList:Array = nfAnimationNode.getPropertyList(object, conf);
			if (propList.length > 0 || conf.delay is Number) {
				nfAnimationNode._canCreate = true;
				conf.prop = propList;
				var node:nfAnimationNode = new nfAnimationNode(object, conf);
				nfAnimationNode._canCreate = false;
				return node;
			}
			return null;
		}
		
		static private function getPropertyList(object:Object, conf:Object):Array {
			var list:Array = new Array;
			for(var prop:String in conf) {
				if (nfAnimationNodeProp.isAllowedProperty(prop)) {
					if (object.hasOwnProperty(prop)) {
						list.push({prop: prop, finish: conf[prop]});
					}
				}
			}			
			return list;
		}
		
		/*
		 * object
		 */
		private var _object:Object;
		public function get object():Object {
			return this._object;
		}
		public function set object(value:Object):void {
			this._object = value;
		}
		
		/*
		 * time
		 */
		private var _time:Number = 0;
		public function get time():Number {
			return this._time;
		}
		public function set time(value:Number):void {
			this._time = value;
		}
		
		/*
		 * revers
		 */
		private var _revers:Boolean = false;
		public function get revers():Boolean {
			return this._revers;
		}
		public function set revers(value:Boolean):void {
			this._revers = value;
		}
		
		/*
		 * delay
		 */
		private var _delay:Number = 0;
		public function get delay():Number {
			return this._delay;
		}
		public function set delay(value:Number):void {
			this._delay = value;
		}
		
		/*
		 * onComplete
		 */
		private var _onComplete:Function = null;
		public function get onComplete():Function {
			return this._onComplete;
		}
		public function set onComplete(value:Function):void {
			this._onComplete = value;
		}
		
		/*
		 * mirror
		 */
		private var _mirror:Boolean = false;
		public function get mirror():Boolean {
			return this._mirror;
		}
		public function set mirror(value:Boolean):void {
			this._mirror = value;
		}
		
		/*
		 * useSeconds
		 */
		private var _useSeconds:Boolean = true;
		public function get useSeconds():Boolean {
			return this._useSeconds;
		}
		public function set useSeconds(value:Boolean):void {
			this._useSeconds = value;
		}

		/*
		 * transition
		 */
		private var _transition:Function;
		public function get transition():Function {
			return this._transition;
		}
		public function set transition(value:Function):void {
			this._transition = value;
		}
		
		
		/*
		 * prop
		 */
		private var _prop:Array = new Array;
		public function get prop():Array {
			return this._prop;
		}
		public function set prop(value:Array):void {
			this._prop = value;
		}
		
		/*
		 * relative
		 */
		private var _relative:Boolean = false;
		public function get relative():Boolean {
			return this._relative;
		}
		public function set relative(value:Boolean):void {
			this._relative = value;
		}
		
		
		/*
		 * dynamic properties
		 */
		private function getTime():Number {
			return nfAnimationValue.getValue(this.time);
		}
		private function getBegin(prop:String):Number {
			return this.object[prop] as Number;
		}
		private function getFinish(prop:String, value:Object):Number {
			var finish:Number = nfAnimationValue.getValue(value); //for extras
			if (this.relative) {
				return this.getBegin(prop) + finish;
			}
			return finish;
		}
	}

}