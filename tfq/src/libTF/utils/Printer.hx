package libTF.utils;

import flash.events.TimerEvent;
import flash.utils.Timer;

public class Printer 
{
	
	private var toPrint:String;
	private var index:Int;
	private var tickSpeed:Int;
	public var printed:String;
	private var timer:Timer;
	
	inline public function Printer(tick:Int)
	{
		tickSpeed = tick;
		index = 0;
		toPrint = "";
		printed = "";
		
		timer = new Timer(tick);
		timer.addEventListener(TimerEvent.TIMER, tickLetter);
		timer.start();
	}
	
	inline public function setTicker(tick:Int):Void
	{
		tickSpeed = timer.delay = tick;
	}
	
	inline public function resetPrinted():Void
	{
		printed = "";
	}
	
	inline public function setString(str:String):Void
	{
		toPrint = str;
	}
	
	inline public function tickLetter(e:TimerEvent):Void
	{
		if (toPrint.length != 0)
		{
			printed += toPrint.charAt(0);
			toPrint = toPrint.substr(1);
		}
	}
	
}