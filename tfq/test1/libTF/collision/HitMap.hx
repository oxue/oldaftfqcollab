package libTF.collision;
import tFramework.render.PixMap;

/**
 * ...
 * @author TF
 */

class HitMap implements HitArea
{

	public var x:Float;
	public var y:Float;
	public var map:PixMap;
	public var min:UInt;
	public var max:UInt;
	
	public function new(x:Float, y:Float, map:PixMap, min:UInt = 0x00000000, max:UInt = 0x00FFFFFF)
	{
		this.x = x;
		this.y = y;
		this.map = map;
		this.min = min;
		this.max = max;
	}
	
	inline public function collidePoint(x:Float, y:Float)
	{
		var ix:Float = x - this.x;
		var iy:Float = y - this.y;
		if (ix < 0 || iy < 0 || ix > map.width || iy > map.height) { return false; }
		else
		{
			var px:UInt = map.getPixel32(ix, iy);
			return (px > max || px < min);
		}
	}
	
}