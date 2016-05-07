package libTF.collision;

/**
 * ...
 * @author TF
 */

class HitCircle implements HitArea
{

	public var x:Float;
	public var y:Float;
	public var radius(default, setRad):Float;
	private var radsq:Float;
	
	public function setRad(v:Float):Float
	{
		radsq = radius * radius;
		return radius;
	}
	
	public function new(x:Float, y:Float, radius:Float)
	{
		this.x = x;
		this.y = y;
		this.radius = radius;
	}
	
	public function collidePoint(x:Float, y:Float)
	{
		var dx:Float = this.x - x;
		var dy:Float = this.y - y;
		return (dx*dx + dy*dy < radsq );
	}
	
}