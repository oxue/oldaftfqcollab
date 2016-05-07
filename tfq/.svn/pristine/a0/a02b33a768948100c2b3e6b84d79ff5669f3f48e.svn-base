package libTF.dataStructures;
import flash.Vector;

class Vector2D<T> implements haxe.rtti.Generic
{

	private var data:Vector<T>;
	public var width:Int;
	public var height:Int;
	private var defaultVal:T;
	
	public function new(width:Int, height:Int, defaultVal:T, init:Bool = true) 
	{
		this.width = width;
		this.height = height;
		this.defaultVal = defaultVal;
		data = new Vector<T>(width * height, true);
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
	
	inline public function get(x:Int, y:Int):T
	{
		var ind:Int = x + y * width;
		if (ind < 0 || ind >= Std.int(data.length)) { return defaultVal; }
		else { return data[ind]; }
	}
	
	inline public function set(x:Int, y:Int, v:T):Void
	{
		var ind:Int = x + y * width;
		if (ind < 0 || ind >= Std.int(data.length)) { return; }
		else { data[ind] = v; }
	}
	
	inline public function populate(x:Int, y:Int, vect:Vector2D<T>):Void
	{
		var i:Int = 0;
		var j:Int = 0;
		while (i < vect.width && i + x < width)
		{
			while (j < vect.height && j + y < height)
			{
				set(x + i, y + j, vect.get(i, j));
				j++;
			}
			j = 0;
			i++;
		}
	}
	
	inline public function populateRow(x:Int, y:Int, vect:Vector<T>):Void
	{
		var i:Int = 0;
		while (i < Std.int(vect.length) && i + x < width)
		{
			set(x + i, y, vect[i]);
			i++;
		}
	}
	
	inline public function populateRowA(x:Int, y:Int, vect:Array<T>):Void
	{
		var i:Int = 0;
		while (i < Std.int(vect.length) && i + x < width)
		{
			set(x + i, y, vect[i]);
			i++;
		}
	}
	
	inline public function populateColumn(x:Int, y:Int, vect:Vector<T>):Void
	{
		var i:Int = 0;
		while (i < Std.int(vect.length) && i + x < height)
		{
			set(x , y + i, vect[i]);
			i++;
		}
	}
	
	public function toString():String
	{
		var message:String = '';
		var i:Int = 0;
		var j:Int = 0;
		while(j < height) 
		{
			while(i < width) 
			{
				message += Std.string(data[i+j*width])+',';
				i++;
			}
			i = 0;
			j++;
			message += '\n';
		}
		return message;
	}
	
}