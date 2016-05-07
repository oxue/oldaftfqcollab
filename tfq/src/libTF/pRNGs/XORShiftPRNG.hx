package libTF.pRNGs;
	
class XORShiftPRNG
{
	private var x:UInt;
	private var y:UInt;
	private var z:UInt;
	private var w:UInt;
	private var t:UInt;
	private var mod:UInt;
	
	private var sx:UInt;
	private var sy:UInt;
	private var sz:UInt;
	private var sw:UInt;
	
	public function new(X:UInt = 123456789, Y:UInt = 362436069, Z:UInt = 521288629, W:UInt = 88675123)
	{
		sx = x = X;
		sy = y = Y;
		sz = z = Z;
		sw = w = W;
		mod = 2,147,483,647;
	}
	
	public function reset()::Void
	{
		x = sx;
		y = sy;
		z = sz;
		w = sz;
	}
	
	public function reseed(X:UInt = 123456789, Y:UInt = 362436069, Z:UInt = 521288629, W:UInt = 88675123):Void
	{
		sx = x = X;
		sy = y = Y;
		sz = z = Z;
		sw = w = W;
	}
	
	public function next():UInt 
	{
		t = x ^ (x << 11);
		x = y; y = z; z = w;
		return (w = w ^ (w >> 19) ^ (t ^ (t >> 8)));
	}
	
	public function nextMod():Float
	{
		t = x ^ (x << 11);
		x = y; y = z; z = w;
		w = w ^ (w >> 19) ^ (t ^ (t >> 8))
		return (cast(w, Float) / cast(mod, Float))
	}
	
	public function nextRange(min:Float = 0, max:Float = 1):Float
	{
		t = x ^ (x << 11);
		x = y; y = z; z = w;
		w = w ^ (w >> 19) ^ (t ^ (t >> 8))
		return (cast(w, Float) / cast(mod, Float) * (max-min) + min)
	}
	
}