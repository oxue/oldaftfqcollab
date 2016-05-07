package libTF.pRNGs;
import haxe.FastList;

class Bucket
{

	private var closed:FastList<Float>;
	private var open:FastList<Float>;
	private var temp:FastList<Float>;
	
	public function new() 
	{
		open = new FastList<Float>();
		closed = new FastList<Float>();
	}
	
	public function push(v:Float):Void
	{
		closed.add(v);
	}
	
}