package libTF.dataStructures;
import haxe.rtti.Generic;
import org.
	
class GridNode<T> implements Generic
{
	public var data:T;
	
	public var left:GridNode<T>;
	public var up:GridNode<T>;
	public var right:GridNode<T>;
	public var down:GridNode<T>;
	
	public var x:Int;
	public var y:Int;
	
	public function new(dat:T) 
	{
		data = dat;
	}
	
}