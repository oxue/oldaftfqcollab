package libTF.dataStructures;
import haxe.rtti.Generic;

class ListNode<T> implements Generic
{
	public var data:T; 
	
	public var next:ListNode<T>;
	
	public var prev:ListNode<T>;
	
	public function new(dat:T) 
	{
		data = dat;
	}
	
	inline public function splice():Void
	{
		if (next != null) { next.prev = prev; }
		if (prev != null) { prev.next = next; }
	}
	
	inline public function cut():Void
	{
		if (next != null) { next.prev = null; }
		if (prev != null) { prev.next = null; }
	}
	
	public function graftAfter(dat:T):ListNode<T>
	{
		var node:ListNode<T> = new ListNode<T>(dat);
		if (next != null) {next.prev = node;}
		node.next = next;
		node.prev = this;
		next = node;
		return node;
	}
	
	public function graftBefore(dat:T = null):ListNode<T>
	{
		var node:ListNode<T> = new ListNode<T>(dat);
		if (prev != null) {prev.next = node;}
		node.prev = prev;
		node.next = this;
		prev = node;
		return node;
	}
	
}