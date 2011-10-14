package nextFramework.animation
{
	/**
	 * nfAnimation extention for nF, for animation control
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	 
	import nextFramework.IExtension;
	import nextFramework.nF;

	final public class nfAnimation implements IExtension
	{
		static private var isInit:Boolean = false;
		
		static public function init():void {
			
			if (nfAnimation.isInit) return;
			nfAnimation.isInit = true;
			
			nF.extend(
				'ani',
				function(conf:Object, command:String = "animate"):nF {
					var animator:nfAnimator = nfAnimator.instance;
					for each(var node:Object in this.selection) {
						switch(command) {
							case "removeAll":
								animator.removeAll(node);
								break;
							case "stop":
								animator.stop(node, conf);
								break;
							default:
								animator.animate(node, conf);
						}
						
					}
					return this;
				}
			);
			
		}
		
	}

}