package tFramework.render;

/**
 * ...
 * @author 
 */

class AnimationOptions
{
	public var frameskip:Int;
	public var tickDelay:Int;
	public var paused:Bool;
	public var looping:Bool;
	public var framesTicked:Int;

	public function new(frameskip:Int = 1, tickDelay:Int = 0, paused:Bool = false, looping:Bool = true, framesTicked:Int = 0) 
	{
		this.frameskip = frameskip;
		this.tickDelay = tickDelay;
		this.paused = paused;
		this.looping = looping;
		this.framesTicked = framesTicked;
	}
	
	public function clone():AnimationOptions
	{
		return new AnimationOptions(frameskip, tickDelay, paused, looping, framesTicked);
	}
	
}