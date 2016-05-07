package libTF.utils;

import flash.geom.Point;

class Float2D extends Point
{
	
	public function new(x:Float, y:Float) 
	{
		super(x, y);
	}
	
	public function scale(val:Float):Float2D
	{
		x *= val;
		y *= val;
		return this;
	}
	
	public function ptScale(pt:Point):Float2D
	{
		x *= pt.x;
		y *= pt.y;
		return this;
	}
	
	public function tAdd(pt:Point):Float2D
	{
		x = x + pt.x;
		y = y + pt.y;
		return this;
	}
	
	public function tSubtract(pt:Point):Float2D
	{
		x = x - pt.x;
		y = y - pt.y;
		return this;
	}
	
	public function negative():Float2D
	{
		x *= -1;
		y *= -1;
		return this;
	}
	
	public function invert():Float2D
	{
		var temp:Float = x;
		x = y;
		y = temp;
		return this;
	}
	
	public function norm():Float2D
	{
		x /= length;
		y /= length;
		
		return this;
	}
	
	public function tClone():Float2D
	{
		return new Float2D(x, y);
	}
	
}