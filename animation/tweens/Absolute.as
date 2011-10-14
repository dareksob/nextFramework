package nextFramework.animation.tweens 
{
	
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class Absolute extends Relative
	{
		
		public function Absolute(conf:Object) 
		{
			super(conf);	
			this.end -= this._start;
		}
		
	}

}