package libTF.utils;


class Point3D
{

	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	public function new(x:Float, y:Float, z:Float) 
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public function add(p:Point3D):Point3D
	{
		var p2:Point3D = clone();
		p2.x += p.x;
		p2.y += p.y;
		p2.z += p.z;
		return p2;
	}
	
	public function scale(v:Float):Point3D
	{
		var p:Point3D = clone();
		p.x = p.x * v;
		p.y = p.y * v;
		p.z = p.z * v;
		return p;
	}
	
	public function dot(p:Point3D):Float
	{
		return (x * p.x + y * p.y + z * p.z);
	}
	
	public function cross(p:Point3D):Point3D
	{
		var p2:Point3D = new Point3D(0, 0, 0);
		p2.x = y * p.z - z * p.y;
		p2.y = z * p.x - x * p.z;
		p2.z = x * p.y - y * p.x;
		
		return p2;
	}
	
	public function magnitude():Float
	{
		return Math.sqrt(x * x + y * y + z * z);
	}
	
	public function norm():Point3D
	{
		return scale(1 / magnitude());
	}
	
	public function clone():Point3D
	{
		return new Point3D(x, y, z);
	}
	
	public function equals(p:Point3D):Bool
	{
		return (p.x == x && p.y == y && p.z == z);
	}
	
}