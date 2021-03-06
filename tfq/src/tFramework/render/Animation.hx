package tFramework.render;
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

class Animation implements Animated
{
	public var frames:Vector<Renderable>;
	public var options:AnimationOptions;
	
	public var currentFrame(default, setCurrentFrame):Int;
	public var finalFrame(default, null):Int;
	
	public function setCurrentFrame(frame:Int):Int
	{
		return (currentFrame = frame % frames.length);
	}
	
	public function new(frames:Vector<Renderable>, options:AnimationOptions = null ) 
	{
		this.frames = frames;
		if (options == null) { this.options = new AnimationOptions(); }
		else { this.options = options; }
		
		currentFrame = 0;
		finalFrame = frames.length - 1;
	}
	
	public function render(map:PixMap, context:RenderContext):Void
	{
		if (context == null) { context = new RenderContext(); }
		
		frames[currentFrame].render(map, context);
	}
	
	public function tick():Void
	{
		if (!options.paused)
		{
			options.framesTicked++;
			if (options.framesTicked > options.tickDelay)
			{
				if (!options.looping && currentFrame + options.frameskip >= Std.int(frames.length))
				{
					currentFrame = frames.length -1;
					options.paused = true;
				}
				else
				{
					currentFrame += options.frameskip;
				}
				options.framesTicked = 0;
			}
		}
	}
	
}