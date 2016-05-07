/*
 * To use, you must import:
 * flash.events.Event;
 * import flash.events.EventDispatcher;
 * import flash.events.IEventDispatcher;
 *
 * And then
 * include libTF.utils.DispatchEvents
 * within the class
 */

private var _ed:EventDispatcher;

public function addEventListener(type:String, listener:Event->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void
{
	_ed.addEventListener(type, listener, useCapture, priority, useWeakReference);
}

public function removeEventListener(type:String, listener:Event->Void, useCapture:Bool = false):Void
{
	_ed.removeEventListener(type, listener, useCapture);
}

public function dispatchEvent(event:Event):Bool
{
	return _ed.dispatchEvent(event);
}

public function hasEventListener(type:String):Bool
{
	return _ed.hasEventListener(type);
}

public function willTrigger(type:String):Bool
{
	return _ed.willTrigger(type);
}