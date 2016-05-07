package libTF.utils;
	
public class BetterTimer 
{
	
	private var startTime:Float;
	private var pauseTime:Float;
	public var running:Bool;
	public var paused:Bool;
	
	public function new() 
	{
		startTime = 0;
		pauseTime = 0;
		running = false;
		paused = false;
	}
	
	public function start():Void
	{
		startTime = (new Date()).getTime();
		running = true;
	}
	
	public function getTime():Float
	{
		if (running) { return ((new Date()).getTime() - startTime); }
		else { return 0; }
	}
	
	public function stop():Float
	{
		if (running) { return (new Date()).getTime() - startTime; running = false; paused = false; }
		else { return 0; }
	}
	
	public function pause():Void
	{
		if (running && !paused) { pauseTime = (new Date()).getTime(); paused = true; }
	}
	
	public function resume():Void
	{
		if (running && paused) { startTime += (new Date()).getTime() - pauseTime; paused = false; }
	}
	
	public static function currentTime():Float
	{
		return (new Date()).getTime();
	}
}