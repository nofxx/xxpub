package comps.src.pad.data
{

	import flash.geom.Point;
	
	public class DrawingPoint
	{
		
		public static const NORMAL:int = 0;
		public static const PRESS:int = 2;
		public static const RELEASE:int = 4;
		
		public var point:Point;
		public var type:int;
		
		
		public function DrawingPoint(p_point:Point=null, p_type:int=0)
		{
			point = p_point;
			type = p_type;
		}
			
	}
}