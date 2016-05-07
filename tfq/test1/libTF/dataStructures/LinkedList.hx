package libTF.dataStructures;
import haxe.rtti.Generic;

class LinkedList<T> implements Generic
{
	public var first:ListNode<T>;
	public var last:ListNode<T>;
	
	public function new(node:ListNode<T>)
	{
		first = last = node;
	}
	
	public function addStart(node:ListNode<T>):Void
	{
		node.next = first;
		first.prev = node;
		first = node;
	}
	
	public function addEnd(node:ListNode<T>):Void
	{
		node.prev = last;
		last.next = node;
		last = node;
	}
	
	public function spliceStart():ListNode<T>
	{
		var ret:ListNode<T> = first;
		first = first.next;
		if (first != null) { first.prev = null; }
		return ret;
	}
	
	public function spliceEnd():ListNode<T>
	{
		var ret:ListNode<T> = last;
		last = last.prev;
		if (last != null) {last.next = null;}
		return ret;
	}
	
	public function clear():Void
	{
		first = last = null;
	}
	
}