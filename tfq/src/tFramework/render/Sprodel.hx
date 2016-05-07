package tFramework.render;
import flash.Vector;
import flash.utils.TypedDictionary;

/**
 * ...
 * @author 
 */

class Sprodel implements Animated
{

	//TODO default state? 'Missing image' thing
	//public static var noState:Animation
	
	public var currentState(default, null):Animation;
	public var stateName(default, null):String;
	private var states:TypedDictionary<String,Animation>;
		
	public function new() 
	{
		states = new TypedDictionary<String,Animation>();
	}
	
	public function addState(anim:Animation, name:String):Void
	{
		states.set(name, anim);
	}
	
	public function removeState(name:String):Void
	{
		//RESOLVE should I be able to remoev current state?
		if (states.exists(name)) { states.delete(name); }
	}

	public function getState(name:String):Animation
	{
		if (states.exists(name)) { return states.get(name); }
		else { return null; }
	}
	
	public function setState(name:String):Void
	{
		if (states.exists(name)) { currentState = states.get(name); stateName = name; }
	}
	
	public function tick():Void
	{
		currentState.tick();
	}
	
	public function render(map:PixMap, ctx:RenderContext):Void
	{
		currentState.render(map, ctx);
	}
	
}