package nextFramework.transform 
{
	import flash.geom.Point;
	import nextFramework.utils.nfBoxPoints;
	
	/**
	 * 
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
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
		
		public static const ABSLEFTTOP:String = 'absLeftTop';
		
		/**
		 * value
		 */
		private var _value:String;
		public function get value():String { 
			return this._value; 
		}
		public function set value(value:String):void {
			this._value = value;
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
					
				case ABSLEFTTOP:
					return boxpoint.absLeftTop;
			}
			return new Point();
		}
		
		public function toString():String {
			return this.value;
		}
		
	}

}