package nextFramework.animation 
{
	import nextFramework.collection.IKeyValueNode;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.utils.rendering.nfRender;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfAnimator
	{
		private var _timelineCollection:nfKeyValueCollection;

		/**
		 * add and start the animation process for the object
		 * 
		 * @param	object, what have to animate
		 * @param	conf, animtion configuration
		 * @return	nfAnimator
		 */
		public function animate(object:Object, conf:Object):nfAnimator {
			var timeline:nfTimeline = this._timelineCollection.getNodeByKey(object) as nfTimeline;
			
			//create new timeline of not exits
			if (!timeline) {
				timeline = new nfTimeline(object);
				this._timelineCollection.add(new nfKeyValueNode(object, timeline));
			}
			
			timeline.add(conf);
			
			return this;
		}
		
		/**
		 * remove all animations of object if exists
		 * 
		 * @param	object
		 * @return	nfAnimator
		 */
		public function removeAll(object:Object):nfAnimator {
			if (object is nfTimeline) {
				this._timelineCollection.removeByKey((object as nfTimeline).target);
			}else {
				this._timelineCollection.removeByKey(object);
			}
			return this;
		}
		
		public function stop(object:Object, conf:Object = null):nfAnimator {
			var timeline:nfTimeline = this.getTimelineByObject(object);
			if (timeline) {
				timeline.stop(conf);
			}else {
				//todo log
			}
			return this;
		}
		
		/**
		 * return a nfTimeline to object if exists
		 * @param	object
		 * @return	nfTimeline or null
		 */
		public function getTimelineByObject(object:Object):nfTimeline {
			var node:nfKeyValueNode = this._timelineCollection.getNodeByKey(object) as nfKeyValueNode;
			if (node) {
				return node.value as nfTimeline;
			}
			return null;
		}
		
		/**
		 * animate timelines
		 * @param	time
		 */
		private function update(time:Number):void {
			var removeIndices:Array = new Array;
			
			var node:IKeyValueNode;
			for (var index:int = 0; index < this._timelineCollection.collection.length; index++) {
				node = this._timelineCollection.collection[index];
				if (node.value.update(time)) {
					//if finished add to remove list
					removeIndices.push(index);
				}
			}
			
			if(removeIndices.length > 0){
				this._timelineCollection.removeByIndices(removeIndices);
			}
		}
		
		
		
		/**
		 * singelton contruct
		 */
		static private var _instance:nfAnimator = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfAnimator
		{
			if (nfAnimator._instance == null) {
				nfAnimator._canCreate = true;
				nfAnimator._instance = new nfAnimator();
				nfAnimator._canCreate = false;
			}
			return nfAnimator._instance;
		}
		
		/**
		 * contructor singelton
		 */
		public function nfAnimator()
		{
			if(!nfAnimator._canCreate){
				throw new Error('nfAnimator is a singelton class.');
			}
			
			this._timelineCollection = new nfKeyValueCollection();
			nfRender.instance.addRender(this.update);
		}
		
	}

}