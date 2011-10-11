package nextFramework.utils.converter 
{
	import flash.geom.Point;
	import nextFramework.drawing.nfDrawingData;
	import nextFramework.utils.IHelper;
	import nextFramework.nfRegistry;
	/**
	 * helper class convert a nfDrawingData to straight point vector
	 * @author Darius Sobczak
	 */
	public class nfDrawingDataConverter implements IConverter, IHelper
	{
		public static function create():* {
			return new nfDrawingDataConverter;
		}
		
		/**
		 * convert a nfDrawingData to straight point vector
		 * 
		 * @param	data, nfDrawingData
		 * @return	return a point vector
		 */
		public function convert(data:*):*{
			if (data is nfDrawingData) {
				var drawingData:nfDrawingData = (data as nfDrawingData);
				var pointData:Vector.<Number> = drawingData.data;
				var pointvector:Vector.<Point> = new Vector.<Point>();
				var dataIndex:int = 0;
			
				for each(var command:int in drawingData.command) {
					var point:Point = null;
					switch(command) {
						case 1: //move to
						case 2: //line to
						case 4: //wide move to
						case 5: //wide line to
							point = new Point(pointData[dataIndex++], pointData[dataIndex++]);
							break;
						case 3: //curve to
							point = new Point(pointData[dataIndex++], pointData[dataIndex++]);
							dataIndex += 2;
							break;
					}
					if (point) {
						pointvector.push(point);
					}
				}
				
				return pointvector;
			}else {
				nfRegistry.addLog("Data Object is not a nfDrawingData class");
			}
			return null;
		}
		
	}

}