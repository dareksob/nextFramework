package nextFramework.display 
{
	import flash.display.Sprite;
	import nextFramework.component.IComponentContainer;
	import nextFramework.component.nfComponentObjectContainer;
	
	/**
	 * Extend Sprite Object with ComponentContainer
	 *
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.09
	 */
	public class CSprite extends Sprite implements IComponentContainer 
	{
		
		public function CSprite() 
		{
			this._componentContainer = new nfComponentObjectContainer(this);
		}
		
		/* INTERFACE nextFramework.component.IComponentContainer */
		private var _componentContainer:nfComponentObjectContainer;
		public function get componentContainer():nfComponentObjectContainer 
		{
			return this._componentContainer;
		}
		
	}

}