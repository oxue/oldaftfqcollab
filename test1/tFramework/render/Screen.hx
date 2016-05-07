package tFramework.render;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.PixelSnapping;
import flash.display.Stage;
import flash.geom.Point;

class Screen 
{
	//MAYBE float scale?
	
	public static var buffer:PixMap;
	private static var display:PixMap;
	private static var bitmap:Bitmap;
	private static var point:Point;
	
	public static function setup(stage:DisplayObjectContainer, scale:Int = 1, color:UInt = 0xFFFFFF):Void
	{
		if (bitmap == null)
		{
			buffer = new PixMap(Std.int(800/scale), Std.int(600/scale), false, color);
			display = new PixMap(Std.int(800/scale), Std.int(600/scale), false, color);
			bitmap = new Bitmap(display);
			bitmap.scaleX = bitmap.scaleY = scale;
			point = new Point(0, 0);
			//stage.showDefaultContextMenu = false;
			stage.addChildAt(bitmap, 0);
		}
		else
		{
			reset(stage, scale, color);
		}
	}
	
	public static function reset(stage:DisplayObjectContainer, scale:Int = 1, color:UInt = 0xFFFFFF):Void
	{
		buffer = new PixMap(Std.int(800/scale), Std.int(600/scale), false, color);
		display = new PixMap(Std.int(800 / scale), Std.int(600
		 / scale), false, color);
		bitmap.bitmapData = display;
		bitmap.scaleX = bitmap.scaleY = scale;
	}
	
	inline public static function flip():Void
	{
		display.copyPixels(buffer, buffer.rect, point);
		buffer.clear();
	}
	
}