package libTF.utils;
import flash.Vector;

/**
 * ...
 * @author TF
 */

class MathUtils 
{
	
	private static var iv:Int;
	private static var sv:Float;
	
	inline public static function ceil(v:Float):Int
	{
		iv = Std.int(v);
		if (iv == v)
		{
			return iv;
		}
		else
		{
			return (v < 0)?(iv):(iv + 1);
		}
	}
	
	inline public static function floor(v:Float):Int
	{
		iv = Std.int(v);
		if (iv == v)
		{
			return iv;
		}
		else
		{
			return (v > 0)?(iv):(iv - 1);
		}
	}
	
	inline public static function abs(number:Float):Float
	{
		return (number > 0)?number: -number;
	}
	
	inline public static function sign(number:Float):Int
	{
		return (number > 0)?1: -1;
	}
	
	inline public static function round(number:Float):Int
	{
		return(( floor(number * 2) + 1) >> 1);
	}
	
	inline public static function sin(x:Float):Float
	{
		x = x % 6.28318531;
		if (x > 3.14159265) { x -= 6.28318531; }
		if (x < -3.14159265) { x += 6.28318531; }
		
		if (x == 0 || x == 3.14159265) { return 0; }
		else if (x == 1.57079632) { return 1; }
		else if (x == -1.57079632) { return -1; }
		else
		{
			if (x < 0)
			{
				sv = 1.27323954 * x + .405284735 * x * x;
			
				if (sv < 0)
					return .225 * (sv *-sv - sv) + sv;
				else
					return .225 * (sv * sv - sv) + sv;
			}
			else
			{
				sv = 1.27323954 * x - 0.405284735 * x * x;

				if (sv < 0)
					return .225 * (sv *-sv - sv) + sv;
				else
					return .225 * (sv * sv - sv) + sv;
			}
		}

	}
	
	inline public static function cos(x:Float):Float
	{
		return sin(x += 1.57079632);
	}
	
	inline public static function tan(x:Float):Float
	{
		return sin(x) / cos(x);
	}
	
	inline public static function min(a:Float, b:Float):Float
	{
		return (a < b)?a:b;
	}
	
	inline public static function max(a:Float, b:Float):Float
	{
		return (a > b)?a:b;
	}
	
	inline public static function imin(a:Int, b:Int):Int
	{
		return (a < b)?a:b;
	}
	
	inline public static function imax(a:Int, b:Int):Int
	{
		return (a > b)?a:b;
	}
	
	inline public static function primeFactors(number:UInt):Vector<UInt>
	{
		var n:UInt = number; 
		var factors:Vector<UInt> = new Vector<UInt>();
		
		var i:UInt = 2;
		while (i <= n / i) 
		{
			while (n % i == 0) 
			{
				factors.push(i);
				n =  Std.int(n / i);
			}
			i++;
		}
		if (n > 1) 
		{
			factors.push(n);
		}
		return factors;
	}
	
}