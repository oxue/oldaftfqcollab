package tk;

import flash.display.Sprite;
import flash.events.MouseEvent;

class Button extends Panel
{
	public var mcallback:Void->Void;

	public function new(_title:String = "default", 
						_width:Int = 60, 
						_height:Int = 20,
						_callback:Void->Void = null)
	{
		super(_title, 
			  _width, 
			  _height,
			  false,
			  false,
			  false,
			  false,
			  true);
		
		mcallback = _callback;

		background.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
	}

	public override function mouseDown(e:MouseEvent):Void
	{

		if(mcallback!=null)
		{
			mcallback();
		}
	}

	public override function closeWindow():Void
	{
		background.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		background.removeEventListener(MouseEvent.MOUSE_DOWN, mouseUp);
		super.closeWindow();
	}
}