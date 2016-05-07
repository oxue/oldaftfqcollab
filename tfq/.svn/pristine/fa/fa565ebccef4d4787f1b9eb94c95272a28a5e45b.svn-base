package libTF.pathfinder;
import libTF.dataStructures.ListNode;

/**
 * ...
 * @author TF
 */

class PathTile 
{
	public var mCost:Int;
	public var blocked:Bool;
	
	public var closed:Bool;
	public var open:Bool;
	
	public var F:Int;
	public var G:Int;
	public var H:Int;
	
	public var parent:ListNode<PathTile>;
	
	public function new(movementCost:Int, block:Bool = false) 
	{
		mCost = movementCost;
		blocked = block;
		closed = false;
		open = false;
	}
}