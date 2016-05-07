package libTF.dataStructures;
import flash.Vector;
import haxe.rtti.Generic;
import libTF.dataStructures.LinkedList;
import libTF.dataStructures.ListNode;
import libTF.dataStructures.ListNode;
import libTF.dataStructures.ListNode;
import libTF.dataStructures.ListNode;
import refraction.core.Component;

/**
 * ...
 * @author TF
 */

class ObjectPool<T> implements Generic
{
	
	private var pool:LinkedList<T>;
	
	public function new() 
	{
		pool = new LinkedList<T>(new ListNode<T>(null));
		pool.clear();
	}
	
	public function get():T
	{
		if (pool.first == null)
		{
			return null;
		}
		else
		{
			return pool.spliceStart().data;
		}
	}
	
	public function release(item:T):Void
	{
		pool.addStart(new ListNode<T>(item));
	}
	
	public function pushVect(v:Vector<T>):Void
	{
		var i:UInt = 0;
		while (i < v.length)
		{
			pool.addStart(new ListNode<T>(v[i]));
			i++;
		}
	}
	
	public function pushArr(a:Array<T>):Void
	{
		var i:Int = 0;
		while (i < a.length)
		{
			pool.addStart(new ListNode<T>(a[i]));
			i++;
		}
	}
	
	
}