package nextFramework.animation 
{
	import flash.utils.getDefinitionByName;
	import nextFramework.animation.tweens.Absolute;
	import nextFramework.animation.tweens.ITween;
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfTweenFactory
	{
		/** default setting type */
		static public var defaultTweenClass:Class = Absolute;
				
		public static const tweenNamespace:String = "nextFramework.animation.tweens.";
		
		
		static public function factory(conf:Object):ITween {
			if (conf is ITween) {
				return conf as ITween;
			}
			
			//create class
			var tweenClass:Class;
			if (conf.hasOwnProperty("type")) {
				if(conf.type is Class){
					tweenClass = conf.type as Class;
				}else{
					tweenClass = getDefinitionByName(nfTweenFactory.tweenNamespace + conf.type) as Class;
				}
			}else {
				tweenClass = nfTweenFactory.defaultTweenClass;
			}
			
			//init class
			var tween:Object = new tweenClass(conf);
			
			if(!(tween is ITween)){
				throw new Error("Class is not a ITween Object");
			}

			return tween as ITween;
		}
		
	}

}