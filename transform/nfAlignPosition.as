package nextFramework.transform 
{
	import flash.geom.Point;
	import nextFramework.utils.nfBoxPoints;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.05 beta
	 */
	public class nfAlignPosition
	{
		
		public function nfAlignPosition(value:String = 'leftTop') 
		{
			this.value = value;
		}
		
		/*
		 * align const
		 */
		public static const LEFTTOP:String = 'leftTop';
		public static const CENTERTOP:String = 'centerTop';
		public static const RIGHTTOP:String = 'rightTop';
		
		public static const LEFTCENTER:String = 'leftCenter';
		public static const CENTER:String = 'center';
		public static const RIGHTCENTER:String = 'rightCenter';
		
		public static const LEFTBOTTOM:String = 'leftBottom';
		public static const CENTERBOTTOM:String = 'centerBottom';
		public static const RIGHTBOTTOM:String = 'rightBottom';
		
		/*
		 * value
		 */
		private var _value:String;
		public function get value():String { 
			return this._value; 
		}
		public function set value(value:String):void {
			switch(value) {
				case LEFTTOP:
					this._value = LEFTTOP; 
					break;
				case CENTERTOP:
					this._value = CENTERTOP; 
					break;
				case RIGHTTOP:
					this._value = RIGHTTOP; 
					break;
					
				case LEFTCENTER:
					this._value = LEFTCENTER; 
					break;
				case CENTER:
					this._value = CENTER; 
					break;
				case RIGHTCENTER:
					this._value = RIGHTCENTER; 
					break;
					
				case LEFTBOTTOM:
					this._value = LEFTBOTTOM; 
					break;
				case CENTERBOTTOM:
					this._value = CENTERBOTTOM; 
					break;
				case RIGHTBOTTOM:
					this._value = RIGHTBOTTOM; 
					break;
					
				default: 
					this._value = LEFTTOP; 
			}
		}
		
		public static function getPointByBoxPoint(align:String, boxpoint:nfBoxPoints):Point {
			var alignPosition:nfAlignPosition = new nfAlignPosition(align);
			
			switch(alignPosition.value) {
				case LEFTTOP:
					return boxpoint.leftTop;
				case CENTERTOP:
					return new Point(boxpoint.centerPoint.x, boxpoint.leftTop.y);
				case RIGHTTOP:
					return boxpoint.rightTop;
					
				case LEFTCENTER:
					return new Point(boxpoint.leftTop.x, boxpoint.centerPoint.y);
				case CENTER:
					return boxpoint.centerPoint;
				case RIGHTCENTER:
					return new Point(boxpoint.rightTop.x, boxpoint.centerPoint.y);
					
				case LEFTBOTTOM:
					return boxpoint.leftBottom;
				case CENTERBOTTOM:
					return new Point(boxpoint.centerPoint.x, boxpoint.leftBottom.y);
				case RIGHTBOTTOM:
					return boxpoint.rightBottom;
			}
			return new Point();
		}
		
		public function toString():String {
			return this.value;
		}
		
	}

}