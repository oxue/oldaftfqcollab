package libTF.utils;
import flash.Vector;

class Fraction
{
	private var numerator:UInt;
	private var denomenator:UInt;
	private var pos:Bool;
	public var value:Float;
	
	public function new(num:UInt, denom:UInt, positive:Bool) 
	{
		numerator = num;
		denomenator = denom;
		pos = positive;
		simplify();
	}
	
	public function gcf(val1:UInt, val2:UInt):UInt
	{
		var numfact:Vector<UInt> = MathUtils.primeFactors(val1);
		var denomfact:Vector<UInt> = MathUtils.primeFactors(val2);
		
		var val:UInt = 1;
		
		var i:UInt = numfact.length - 1;
		while (i != 4294967295)
		{
			var j:UInt = denomfact.length - 1;
			while (j != 4294967295)
			{
				if (numfact[i] == denomfact[j]) 
				{ 
					val *= numfact[i]; 
					numfact.splice(i, 1); 
					denomfact.splice(j, 1);
					break;
				}
				j--;
			}
			i--;
		}
		
		return val;
	}
	
	public function simplify():Fraction
	{
		var factor:UInt = gcf(numerator,denomenator);
		numerator = cast(cast(numerator , Float)/factor,UInt);
		denomenator = cast(cast(denomenator , Float)/factor,UInt);
		cacheValue();
		return this;
	}
	
	inline public function addFract(val:Fraction):Fraction
	{
		numerator = numerator * val.denomenator + val.numerator * denomenator;
		denomenator = denomenator * val.denomenator;
		pos = (value + val.value >= 0);
		return simplify();
	}
	
	inline public function subFract(val:Fraction):Fraction
	{
		numerator = numerator * val.denomenator - val.numerator * denomenator;
		denomenator = denomenator * val.denomenator;
		pos = (value - val.value >= 0);
		return simplify();
	}
	
	inline public function multFract(val:Fraction):Fraction
	{
		numerator *= val.numerator;
		denomenator *= val.denomenator;
		pos = (pos == val.pos);
		return simplify();
	}
	
	inline public function divFract(val:Fraction):Fraction
	{
		numerator *= val.denomenator;
		denomenator *= val.numerator;
		pos = (pos == val.pos);
		return simplify();
	}
	
	inline public function addInt(val:Int):Fraction
	{
		numerator += denomenator * val;
		pos = (value + val >= 0);
		return simplify();
	}
	
	inline public function subInt(val:Int):Fraction
	{
		numerator -= denomenator * val;
		pos = (value - val >= 0);
		return simplify();
	}
	
	inline public function multInt(val:Int):Fraction
	{
		numerator *= val;
		pos = (pos == (val >= 0));
		return simplify();
	}
	
	inline public function divInt(val:Int):Fraction
	{
		denomenator *= val;
		pos = (pos == (val >= 0));
		return simplify();
	}
	
	inline public function reciprocal():Fraction
	{
		return (new Fraction(denomenator, numerator, pos));
	}
	
	public function wholePart():UInt
	{
		return Std.int(value);
	}
	
	public function fracPart():Fraction
	{
		var part:Fraction = clone();
		part.numerator %= part.denomenator;
		return part;
	}
	
	public function abs():Fraction
	{
		pos = true;
		return (simplify());
	}
	
	private function cacheValue():Float
	{
		value = (pos?1: -1) * cast(numerator, Float) / cast(denomenator, Float);
		return value;
	}
	
	inline public function toString():String
	{
		return ((pos?"":"-") + Std.string(numerator) + "/" + Std.string(denomenator));
	}
	
	public function toMixedNum():String
	{
		return(Std.string(wholePart()) + " and " + fracPart().abs().toString());
	}
	
	inline public function clone():Fraction
	{
		return new Fraction(numerator, denomenator, pos);
	}
}