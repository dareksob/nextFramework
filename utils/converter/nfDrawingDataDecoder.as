package nextFramework.utils.converter 
{
	import nextFramework.drawing.nfDrawingData;
	import nextFramework.extension.simplePhysics.shapes.nfPath;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class nfDrawingDataDecoder
	{
		
		static public function convertPath(path:nfPath):nfDrawingData
		{
			var data:nfDrawingData;
			
			for each(var position in path.points) {
				if (data) {
					data.lineTo(position.x, position.y);
				}else {
					data = new nfDrawingData;
					data.moveTo(position.x, position.y);
				}
			}
			return data;
		}	
		
	}

}