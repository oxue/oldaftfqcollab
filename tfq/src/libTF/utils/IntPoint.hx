package libTF.utils;
import flash.geom.Point;

/**
 * ...
 * @author TF
 */

class IntPoint 
{

	public var x:Int;
	public var y:Int;
	
	public function new(x:Int = 0 ,y:Int = 0) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function toPoint():Point
	{
		return new Point(x, y);
	}
	
}