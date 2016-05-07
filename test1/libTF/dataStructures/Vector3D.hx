package libTF.dataStructures;
import flash.Vector;

class Vector3D<T> implements haxe.rtti.Generic
{

	private var data:Vector<T>;
	private var width:Int;
	private var height:Int;
	private var depth:Int;
	private var defaultVal:T;
	
	public var length:Int;
	
	public function new(width:Int, height:Int, depth:Int, defaultVal:T, init:Bool = true) 
	{
		this.width = width;
		this.height = height;
		this.depth = depth;
		this.defaultVal = defaultVal;
		this.length = width * height * depth;
		data = new Vector<T>(length, true);
		if (init)
		{
			var i:Int = 0;
			while (i < Std.int(data.length))
			{
				data[i] = defaultVal;
				i++;
			}
		}
	}
	
	inline public function get(x:Int, y:Int, z:Int):T
	{
		if (x < 0 || x >= width || y < 0 || y >= height || z < 0 || z >= height) { return defaultVal; }
		else
		{
			var ind:Int = x + y * width + z * width * depth;
			return data[ind];
		}
	}
	
	inline public function set(x:Int, y:Int, z:Int, v:T):Void
	{
		var ind:Int = x + y * width + z * width * depth;
		if (ind < 0 || ind >= Std.int(data.length)) { return; }
		else { data[ind] = v; }
	}
	
	inline public function populate(x:Int, y:Int, z:Int, vect:Vector3D<T>):Void
	{
		var i:Int = 0;
		var j:Int = 0;
		var k:Int = 0;
		while (i < vect.width && i + x < width)
		{
			while (j < vect.height && j + y < height)
			{
				while (k < vect.depth && k + z < depth)
				{
					set(x + i, y + j, z + k, vect.get(i, j, k));
					k++;
				}
				k = 0;
				j++;
			}
			j = 0;
			i++;
		}
	}
	
	inline public function populateLevel(x:Int, y:Int, z:Int, vect:Vector2D<T>):Void
	{
		var i:Int = 0;
		var j:Int = 0;
		while (i < vect.width && i + x < width)
		{
			while (j < vect.height && j + y < height)
			{
				set(x + i, y + j, z, vect.get(i, j));
				j++;
			}
			j = 0;
			i++;
		}
	}
	
	public function toString():String
	{
		var message:String = '';
		var i:Int = 0;
		var j:Int = 0;
		var k:Int = 0;
		while(k < depth) 
		{
			while(j < height) 
			{
				while (i < width)
				{
					message += Std.string(data[i + j * width + k * depth * height]) + ',';
					i++;
				}
				i = 0;
				j++;
				message += '\n';
			}
			j = 0;
			k++;
			message += '\n\nDepth'+k+':\n';
		}
		return message;
	}
	
}