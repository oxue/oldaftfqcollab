package  libTF.pRNGs;
	
//For information on how this PRNG works, see: http://en.wikipedia.org/wiki/Linear_congruential_generator
class LinConPRNG 
{
	
	private var ori:Int;
	private var val:Int;
	private var mult:Int;
	private var inc:Int;
	private var mod:Int;
	
	public function new(seed:Int, multiplier:Int, increment:Int, modulus:Int ) 
	{
		ori = seed;
		val = seed;
		mult = multiplier;
		inc = increment;
		mod = modulus;
	}
	
	public function reset():Int
	{
		val = ori;
		return val;
	}
	
	public function reseed(seed:Int):Int
	{
		val = ori = seed;
		return val;
	}
	
	public function next():Int
	{
		val = (val * mult + inc) % mod;
		return val;
	}
	
	public function nextMod():Float
	{
		val = (val * mult + inc) % mod;
		return (cast(val, Float) / cast(mod, Float));
	}
	
	public function nextRange(min:Float = 0, max:Float = 1):Float
	{
		val = (val * mult + inc) % mod;
		return (cast(val, Float) / cast(mod, Float) * (max - min) + min);
	}
	
}