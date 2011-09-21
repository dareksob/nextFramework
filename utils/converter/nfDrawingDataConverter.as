package nextFramework.utils.converter
{
	import nextFramework.drawing.nfDrawingData;
	import nextFramework.extension.simplePhysics.shapes.*;
	import nextFramework.extension.simplePhysics.*;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfDrawingDataConverter
	{
		
		static public function convertToLineCollection(drawingData:nfDrawingData):nfLineSegmentCollection
		{
			var lineCollection:nfLineSegmentCollection = new nfLineSegmentCollection;
			var lastPoint:nfVector2D;
			var dataIndex:int = 0;
			var data:Vector.<Number> = drawingData.data;
			
			for each(var command:int in drawingData.command) {
				var point:nfVector2D;
				switch(command) {
					case 1: //move to
					case 2: //line to
					case 4: //wide move to
					case 5: //wide line to
						point = new nfVector2D(data[dataIndex++], data[dataIndex++]);
						break;
					case 3: //curve to
						point = new nfVector2D(data[dataIndex++], data[dataIndex++]);
						dataIndex += 2;
						break;
				}
				if (point) {
					if (lastPoint) {
						lineCollection.addByPoints(lastPoint, point);
						lastPoint = null;
					}else {
						lastPoint = point;
					}
				}
			}
			return lineCollection;
		}
		
		static public function convertToPath(drawingData:nfDrawingData):nfPath
		{
			var path:nfPath = new nfPath;
			var dataIndex:int = 0;
			var data:Vector.<Number> = drawingData.data;
			
			for each(var command:int in drawingData.command) {
				var point:nfVector2D;
				switch(command) {
					case 1: //move to
					case 2: //line to
					case 4: //wide move to
					case 5: //wide line to
						point = new nfVector2D(data[dataIndex++], data[dataIndex++]);
						break;
					case 3: //curve to
						point = new nfVector2D(data[dataIndex++], data[dataIndex++]);
						dataIndex += 2;
						break;
				}
				if (point) {
					path.add(point);
				}
			}
			return path;
		}		
	}

}