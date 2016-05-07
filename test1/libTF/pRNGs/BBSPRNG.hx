package libTF.pRNGs;
	
class BBSPRNG 
{
	private var mod:UInt;
	private var ori:UInt;
	private var val:UInt;
	
	public function new(seed:UInt, prime1:UInt = 104729 , prime2:UInt = 99901) 
	{
		ori = val = seed;
		mod = prime1 * prime2;
	}
	
	public function reset():UInt
	{
		val = ori;
		return (val);
	}
	
	public function reseed(seed:UInt):UInt
	{
		val = ori = seed;
		return (val);
	}
	
	public function next():UInt //returns [0, mod)
	{
		val = (val * val) % mod;
		return (val);
	}
	
	public function nextMod():Float // returns [0, 1)
	{
		val = (val * val) % mod;
		return (cast(val, Float) / cast(mod, Float))
	}
	
	public function nextRange(min:Float = 0, max:Float = 1):Float
	{
		val = (val * val) % mod;
		return (cast(val, Float) / cast(mod, Float) * (max-min) + min)
	}
	
}