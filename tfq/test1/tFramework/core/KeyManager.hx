package tFramework.core;

import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.Vector;
	
class KeyManager 
{
	
	public static var keys:Vector<Bool>;
	
	public static function setup(stage:Stage):Void
	{
		keys = new Vector<Bool>(256);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, pressed);
		stage.addEventListener(KeyboardEvent.KEY_UP, released);
	}
	
	private static function pressed(e:KeyboardEvent):Void
	{
		keys[e.keyCode] = true;
	}
	
	private static function released(e:KeyboardEvent):Void
	{
		keys[e.keyCode] = false;
	}
	
	inline public static function isPressed(val:Int):Bool
	{
		if (val > 255) { return false; }
		else { return keys[val]; }
	}
	
	inline public static function isPressedStr(val:String):Bool
	{
		return isPressed(val.toUpperCase().charCodeAt(0));
	}
	
}