package tk;

import flash.display.Sprite;
import flash.events.MouseEvent;
import tk.ToolkitEngine;

class SlideBar extends Sprite
{
	public var thumb:Sprite;
	public var line:Sprite;
	public var sliderWidth:Int;
	public var dragging:Bool;
	public var diff:Int;
	public var maxValue:Int;
	public var value(getValue, setValue):Float;

	public function getValue():Float
	{
		return thumb.x / (sliderWidth - thumb.width) * maxValue;
	}

	public function setValue(value:Float):Float
	{
		thumb.x = value / maxValue * (sliderWidth - thumb.width);
		return thumb.x;
	}

	public function new(_sliderWidth:Int, _maxValue:Int)
	{
		super();
		sliderWidth = _sliderWidth;
		maxValue = _maxValue;

		line = new Sprite();
		line.graphics.lineStyle(1);
		line.graphics.moveTo(0,10);
		line.graphics.lineTo(sliderWidth,10);
		addChild(line);

		thumb = new Sprite();
		thumb.graphics.beginFill(cast ToolkitEngine.settings.get("panel_color2"));
		thumb.graphics.drawRect(0,0,40,20);
		addChild(thumb);

		thumb.addEventListener(MouseEvent.MOUSE_DOWN, dragStart);	
		flash.Lib.current.parent.addEventListener(MouseEvent.MOUSE_MOVE, drag);
		flash.Lib.current.parent.addEventListener(MouseEvent.MOUSE_UP, dragStop);
	}

	public function dragStart(e:MouseEvent):Void
	{
		dragging = true;
		diff = cast thumb.mouseX;
	}

	public function dragStop(e:MouseEvent):Void
	{
		dragging = false;
	}

	public function drag(e:MouseEvent):Void
	{
		if(dragging == true)
		{
			thumb.x = mouseX - diff;
			if(thumb.x < 0)
			{
				thumb.x = 0;
			}
			if(thumb.x > sliderWidth - thumb.width)
			{
				thumb.x = sliderWidth - thumb.width;
			}
		}
	}
}