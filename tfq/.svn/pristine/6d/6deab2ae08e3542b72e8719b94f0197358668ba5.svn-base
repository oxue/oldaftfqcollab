package libTF.utils;
import flash.geom.Rectangle;

/**
 * ...
 * @author 
 */

class IntRect 
{

	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) 
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	public function clone():IntRect
	{
		return new IntRect(x, y, width, height);
	}
	
	public function reset(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0):Void
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	public function contains(x:Int, y:Int):Bool
	{
		return (x > this.x && y > this.y && x < this.x + width && y < this.y + height);
	}
	
	public function equals(r:IntRect):Bool
	{
		return (x == r.x && y == r.y && width == r.width && height == r.height);
	}
	
	public function intersection(r:IntRect):IntRect
	{
		var rect:IntRect = new IntRect(MathUtils.imax(x, r.x), MathUtils.imax(y, r.y));
		rect.width = MathUtils.imin(x + width, r.x + r.width) - rect.x;
		rect.height = MathUtils.imin(y + height, r.y + r.height) - rect.y;
		if (width < 0 || height < 0) { rect.reset(0, 0, 0, 0); }
		return rect;
	}
	
	public function union(r:IntRect):IntRect
	{
		var rect:IntRect = new IntRect(MathUtils.imin(x, r.x), MathUtils.imin(y, r.y));
		rect.width = MathUtils.imax(x + width, r.x + r.width) - rect.x;
		rect.height = MathUtils.imax(y + height, r.y + r.height) - rect.y;
		return rect;
	}
	
	public function containsRect(r:IntRect):Bool
	{
		return (r.x >= x && r.y >= y && r.width + r.x < width + x && r.height + r.y < height + y);
	}
	
	public function toRect():Rectangle
	{
		return new Rectangle(x, y, width, height);
	}
	
	public static function fromRect(r:Rectangle):IntRect
	{
		return new IntRect(MathUtils.floor(r.x), MathUtils.floor(r.y), MathUtils.ceil(r.width), MathUtils.ceil(r.height));
	}
	
}