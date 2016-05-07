package game.terrainGeneration;
import flash.Vector;
import libTF.pRNGs.LinConPRNG;

/**
 * ...
 * @author TF
 */

class Heightmap
{
	
	public var data:Vector<Int>;
	
	public var top:Int;
	public var bottom:Int;
	
	public var PRNG:LinConPRNG;
	
	public function new(length:UInt, PRNG:LinConPRNG, top:Int, bottom:Int) 
	{
		data = new Vector<Int>(length, true);
		
		this.top = top;
		this.bottom = bottom;
		this.PRNG = PRNG;
	}
	
	/* This one normalizes propery based on strength criteria (0 = no change, 1 = flat)
	 * However, it does not provide the kind of normalization I want.
	 * It basically just scales the heightmap, relative to the average height
	 * I am looking for something more like "smoothing"
	 */
	
	public function flatten(strength:Float):Void
	{
		var strength2:Float = 1 - strength;
		
		var avg:Int = 0;
		var i:UInt = 0;
		while (i < data.length)
		{
			avg += data[i];
			i++;
		}
		avg = Std.int(avg/data.length);
		
		i = 0;
		while (i < data.length)
		{
			data[i] = Std.int(data[i] * strength2 + avg * strength);
			i++;
		}
	}
	
	/* This one averages each set of 3, based on strength, and pushes the value into a new vector
	 * the kid of normalization it provides is closer to what I'd like (Still not ideal)
	 * But the criteria for how strength plays in are not met
	 */
	
	public function normalize(strength:Float):Void
	{
		var strength2:Float = 1 - strength;
		
		var result:Vector<Int> = new Vector<Int>(data.length, true);
		
		result[0] = Std.int(data[1] * strength + data[0] * strength2);
		
		var i:UInt = 1;
		while (i < cast(data.length - 1, UInt))
		{
			result[i] = Std.int((data[i - 1] + data[i + 1]) / 2 * strength + data[i] * strength2);
			i++;
		}
		
		result[data.length - 1] = Std.int(data[data.length - 2] * strength + data[data.length - 1] * strength2);
		
		data = result;
	}
	
	public function randomize():Void
	{
		var i:UInt = 0;
		while (i < data.length)
		{
			data[i] = Std.int(PRNG.nextRange(bottom, top));
			i++;
		}
	}
	
}