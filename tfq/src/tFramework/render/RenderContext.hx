package tFramework.render;

import libTF.utils.IntRect;
import libTF.utils.MathUtils;

/**
 * ...
 * @author truefire]
 */

class RenderContext 
{

	public var x:Float;
	public var y:Float;
	public var rotation:Float;
	public var originX:Float;
	public var originY:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	public var fliph:Bool;
	public var flipv:Bool;
	public var clipping:IntRect;
	public var border:IntRect;
	
	//Order of operations: clipping, flipping, scale, rotation, bordering
	public function new(x:Float = 0, y:Float = 0, rotation:Float = 0, originX:Float = 0, originY:Float = 0, scaleX:Float = 1, scaleY:Float = 1, fliph:Bool = false, flipv:Bool = false, clipping:IntRect = null, border:IntRect = null) 
	{
		this.x = x;
		this.y = y;
		this.rotation = rotation;
		this.originX = originX;
		this.originY = originY;
		this.scaleX = scaleX;
		this.scaleY = scaleY;
		this.fliph = fliph;
		this.flipv = flipv;
		this.clipping = clipping;
		this.border = border;
	}
	
	public function clone():RenderContext
	{
		return new RenderContext(x, y, rotation, originX, originY, scaleX, scaleY, fliph, flipv, clipping, border);
	}
	
	//TODO how should this work
	public function overlay(ctx:RenderContext)
	{
		
	}
	
	//--------Transformations----------
	
	public function posScale(x:Float, y:Float):Void
	{
		this.x *= x / scaleX;
		this.y *= y / scaleY;
		this.scaleX = x;
		this.scaleY = y;
	}
	
	public function posRotate(r:Float):Void
	{
		var d:Float = Math.sqrt(x * x + y * y);
		rotation += r;
		x = MathUtils.cos(rotation) * d;
		y = MathUtils.sin(rotation) * d;
	}
	
	public function posFlipH():Void
	{
		x = -x;
		fliph = !fliph;
	}
	
	public function posFlipV():Void
	{
		y = -y;
		flipv = !flipv;
	}
	
}