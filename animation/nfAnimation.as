package nextFramework.animation
{
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.0 beta
	 */
	 
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import nextFramework.collection.nfKeyValueCollection;
	import nextFramework.collection.nfKeyValueNode;
	import nextFramework.debug.nfTrace;
	import nextFramework.IExtension;
	import nextFramework.nF;

	final public class nfAnimation implements IExtension
	{
		
		/*
		 * add methodes
		 */
		public function addListAnimation(list:Vector.<Object>, conf:Object):nfAnimation
		{
			if (conf is Object) {
				for each(var node:Object in list) {
					this.addObjectAnimation(node, conf);
				}
			}
			return this;
		}
		
		public function addObjectAnimation(object:Object, conf:Object):nfAnimation
		{
			if (conf) {
				var node:nfAnimationNodeCollection = new nfAnimationNodeCollection(object, conf);
					node.onComplete = this.eventAnimationComplete;
					node.start();
				this.animationCollection.add(new nfKeyValueNode(object, node));
			}
			return this;
		}
		

		private function eventAnimationComplete(node:nfAnimationNodeCollection):void {
			this.animationCollection.removeByValue(node);
		}
		
		private var _animationCollection:nfKeyValueCollection = new nfKeyValueCollection(false);
		private function get animationCollection():nfKeyValueCollection { 
			return this._animationCollection; 
		}
		
		//singelton
		static private var _instance:nfAnimation = null;
		static private var _canCreate:Boolean = false;
		static public function get instance():nfAnimation
		{
			if (nfAnimation._instance == null) {
				nfAnimation._canCreate = true;
				nfAnimation._instance = new nfAnimation();
				nfAnimation._canCreate = false;
			}
			return nfAnimation._instance;
		}
		
		public function nfAnimation() 
		{
			if(!nfAnimation._canCreate){
				throw new Error('nfAnimation is a singelton class.');
			}
		}
		
		//init
		static public function get isInit():Boolean {
			return nfAnimation._instance is nfAnimation;
		}
		
		static public function init():nfAnimation {
			if (nfAnimation.isInit) return nfAnimation.instance;
			
			nF.extend(
				'ani',
				function(conf:Object):nF {
					nfAnimation.instance.addListAnimation(this.selection, conf);
					return this;
				}
			);
			return nfAnimation.instance;
		}
		
	}

}