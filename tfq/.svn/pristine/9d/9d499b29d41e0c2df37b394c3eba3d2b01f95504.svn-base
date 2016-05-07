package tFramework.tile;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.Vector;
import flash.geom.Point;
import haxe.macro.Compiler;
import tFramework.render.PixMap;
import tFramework.render.Renderable;
import tFramework.render.RenderContext;

class SpriteAnim extends Spritesheet, implements Renderable
{
	//include "libTF.utils.DispatchEvents.hx"

	//public static var ON_TICK:String = "Sprite Animation Tick";
	//public static var ON_LOOP:String = "Sprite Animation Loop";
	//public static var ON_PLAY:String = "Sprite Animation Play";
	//public static var ON_PAUSE:String = "Sprite Animation Pause";
	
	public var x:Float;
	public var y:Float;
	
	public var currentImg:PixMap;
	public var currentFrame(default, setCurrentFrame):Int;
	public var finalFrame(default, null):Int;
	public var frameskip:Int;
	public var tickDelay:Int;
	public var paused(default, setPaused):Bool;
	public var looping:Bool;
	public var frames:Vector<Point>;
	private var framesTicked:Int;
	
	public function setCurrentFrame(frame:Int):Int
	{
		//if (frame == frames.length) { dispatchEvent(new Event(ON_LOOP)); }
		currentFrame = frame % frames.length;
		return (currentFrame);
	}
	
	public function setPaused(pause:Bool):Bool
	{
		return paused = pause;
		if (paused && !pause) { paused = false; /*dispatchEvent(new Event(ON_PLAY));*/ }
		else if (!paused && pause) { paused = true; /*dispatchEvent(new Event(ON_PAUSE));*/ }
		
		return paused;
	}
	
	public function new(img:BitmapData, width:Int, height:Int, frames:Vector<Point>, tBorder:Int = 0, tEdge:Int = 0) 
	{
		this.frames = frames;
		this.finalFrame = frames.length - 1;
		super(img, width, height, tBorder, tEdge);
		currentImg = new PixMap(width, height, true, 0x000000);
		currentFrame = 0;
		frameskip = 1;
		tickDelay = 0;
		x = 0;
		y = 0;
		framesTicked = 0;
		paused = false;
		looping = false;
	}
	
	public function cache():Void
	{
		tPoint = frames[currentFrame].clone();
		drawToBMD(Std.int(tPoint.x), Std.int(tPoint.y), 0, 0, currentImg);
	}
	
	public function render(map:PixMap, context:RenderContext):Void
	{
		if (context == null) { context = new RenderContext(); }
		
		cache();
		currentImg.render(map, context);
		//drawToBMD(Std.int(tPoint.x), Std.int(tPoint.y), Std.int(context.x + x), Std.int(context.y + y), map);
	}
	
	public function tick():Void
	{
		if (!paused)
		{
			framesTicked++;
			if (framesTicked > tickDelay)
			{
				//dispatchEvent(new Event(ON_TICK));
				if (!looping && currentFrame + frameskip >= Std.int(frames.length))
				{
					currentFrame = frames.length -1;
					paused = true;
				}
				else
				{
					currentFrame += frameskip;
				}
				framesTicked = 0;
			}
		}
	}
	
}