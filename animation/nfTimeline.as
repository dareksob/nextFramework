package nextFramework.animation 
{
	import fl.motion.easing.Linear;
	import fl.motion.easing.Quadratic;
	import nextFramework.animation.ITimeline;
	import fl.motion.easing.Cubic;
	import nextFramework.animation.tweens.ITween;
	import nextFramework.collection.IKeyValueNode;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.debug.nfTrace;
	import nextFramework.utils.nfObject;
	
	/**
	 * collection of tweens and 
	 * 
	 * @author Darius Sobczak
	 */
	public final class nfTimeline implements ITimeline
	{
		private var _target:Object;
		public var activate:Boolean = true;
		private var _tweensCollection:nfKeyValueCollection;
		
		/** default config */
		static private var defaultCombineConfArray:Array = ["duration", "easing", "type"];
				
		/** default setting easing */
		static public var defaultEasing:Function = Quadratic.easeOut;
		
		/**
		 * return this target object
		 */
		public function get target():Object {
			return this._target;
		}
		
		/**
		 * internal class contructor
		 * @param	target
		 */
		public function nfTimeline(target:Object) 
		{
			this._target = target;
			this._tweensCollection = new nfKeyValueCollection;
		}
		
		/**
		 * add a new tween configuration
		 * @param	conf
		 */
		public function add(conf:Object):nfTimeline {
			//try {
				var duration:Number = isNaN(conf.duration) ? 0 : conf.duration;
				var longestTween:ITween;
				
				//set default configuration object
				var defaultConfiguration:Object = {
					easing: nfTimeline.defaultEasing
				};
				
				nfObject.setPropsByDefault(
					defaultConfiguration, 
					conf,
					nfTimeline.defaultCombineConfArray
				);
				
				for (var key:Object in conf.props) {
			
					//object have to have the property
					if (!this.target.hasOwnProperty(key)) {
						continue;
					}
					
					//set default configuration object for tween 
					var propconf:Object = conf.props[key];
					if (propconf is Number) {
						propconf = { end: propconf };
					}
					
					nfObject.setPropsByDefault(
						propconf, 
						defaultConfiguration,
						nfTimeline.defaultCombineConfArray
					);
					propconf.target = this.target;
					propconf.property = key;
					
					var tween:ITween = nfTweenFactory.factory(propconf);

					this._tweensCollection.add(new nfKeyValueNode(key, tween));
					
					//set longest tween
					if(!longestTween) {
						longestTween = tween;
					}else if (longestTween.duration < tween.duration) {
						longestTween = tween;
					}
				}
				
				//onComplete all tweens
				if(conf.onComplete is Function){
					longestTween.addEventListener(nfTweenEvents.EVENT_COMPLETE, conf.onComplete);
				}
				
			//}catch (error:Error) {
			//	throw new Error("Timeline configuration object is not correct, "+error.message);
			//}
			return this;
		}
		
		public function stop(conf:Object = null):nfTimeline {
			this.activate = false;
			//todo conf
			return this;
		}
		
		public function update(time:Number):Boolean {
			if (this.activate) {
				var removeIndices:Array = new Array;
				var node:IKeyValueNode;
				
				for (var index:int = 0; index < this._tweensCollection.collection.length; index++) {
					node = this._tweensCollection.collection[index];
					
					if ((node.value as ITween).update(time)) {
						//if finished add to remove list
						removeIndices.push(index);
					}
				}
				
				if(removeIndices.length > 0){
					this._tweensCollection.removeByIndices(removeIndices);
					return this._tweensCollection.length == 0;
				}
			}
			return false;
		}		
	}
}