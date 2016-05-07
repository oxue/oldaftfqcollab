package tFramework.core;
	
import flash.display.Stage;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.ui.MouseCursorData;
import tFramework.render.PixMap;
import flash.events.MouseEvent;
import flash.ui.Mouse;
import flash.display.Sprite;
import flash.events.Event;
import flash.Vector;
import tFramework.render.Renderable;

class MouseManager 
{

	public static var cursor:Vector<BitmapData>;
	public static var inStage:Bool;
	public static var isPressed:Bool;
	
	public static function setup(stage:Stage):Void
	{
		stage.addEventListener(Event.MOUSE_LEAVE, function(e:Event):Void { inStage = false; } );
		stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent):Void { inStage = true; } );
		stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):Void { isPressed = true; } );
		stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):Void { isPressed = false; } );
	}
	
	public static function customCursor(bitmaps:Vector<BitmapData>, name:String, hotspot:Point = null):Void
	{
		if (hotspot == null) { hotspot = new Point(); }
		
		var cursorData:MouseCursorData = new MouseCursorData();
		cursorData.hotSpot = hotspot;
		cursorData.data = bitmaps;
		Mouse.registerCursor(name, cursorData);
		Mouse.cursor = name;
		
		cursor = bitmaps;
	}
	
	public static function normalCursor():Void
	{
		Mouse.cursor = flash.ui.MouseCursor.AUTO;
		cursor = null;
	}
	
}