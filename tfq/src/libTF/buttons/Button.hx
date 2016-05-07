package libTF.buttons;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.MouseEvent;
import libTF.collision.HitArea;
import tFramework.core.MouseManager;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.Renderable;
import tFramework.render.RenderContext;

class Button implements Unit
{
	public var x:Float;
	public var y:Float;
	
	private var up:Renderable;
	private var down:Renderable;
	private var over:Renderable;
	private var hit:HitArea;
	
	private var keepDown:Bool;
	
	private var mousedOver:Bool;
	public var pressFunct:Void->Void;
	
	public function new(upState:Renderable, downState:Renderable, overState:Renderable, hitState:HitArea, pressFunc:Void->Void = null, keepDown:Bool = false)
	{
		up = upState;
		down = downState;
		over = overState;
		hit = hitState;
		
		this.keepDown = keepDown;
		
		hitArea = hitState;
		pressFunct = pressFunc;
		mousedOver = false;
		
		addEventListener(MouseEvent.ROLL_OVER, roll);
		addEventListener(MouseEvent.ROLL_OUT, out);
		addEventListener(MouseEvent.MOUSE_DOWN, press);
	}
	
	private function out(e:MouseEvent):Void
	{
		mousedOver = false;
	}
	
	private function roll(e:MouseEvent):Void
	{
		mousedOver = true;
	}
	
	private function press(e:MouseEvent):Void
	{
		if (mousedOver)
		{
			if (pressFunct != null) { pressFunct(); }
		}
	}
	
	public function update():Void
	{
		
	}
	
	public function render(map:PixMap, context:RenderContext == null):Void
	{
		if (context == null) { context = new RenderContext(); }
		
		context.x += this.x;
		context.y += this.y;
		
		if (mousedOver)
		{
			if (MouseManager.isPressed) { down.render(map, context); }
			else { over.render(map, context); }
		}
		else
		{
			up.render(map, context);
		}
	}
	
}