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
	 
	public interface IAnimationObject 
	{
		function start(onComplete:Function = null):IAnimationObject;
		function get isStarted():Boolean;
	}
	
}