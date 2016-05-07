package tk;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.Vector;
import tk.Button;
import editor.EditorCore;
import tk.Panel;
import tk.ToolkitEngine;

class Panel extends Sprite
{
	public var background:Sprite;
	public var title:TextField;
	public var exitButton:Panel;
	public var children:Vector<Panel>;
	public var stackMajorX:Int;
	public var stackMajorY:Int;
	public var onTopOfMe:Vector<Panel>;

	public function new(_title:String = "default", 
						_width:Int = 300, 
						_height:Int = 200, 
						_exitButton:Bool = true,
						_mouseEvents:Bool = true,
						_borderFrame:Bool = true,
						_children:Bool = true,
						_secondary:Bool = false)
	{
		super();
		
		stackMajorX = 10;
		stackMajorY = 30;

		pcdrAddBackground(_width,_height,_borderFrame,_secondary);

		if(_title != '')
		{
			pcdrAddTitleText(_title);
		}

		if(_exitButton == true)
		{
			pcdrSetUpExitButton();
		}
		
		if(_mouseEvents)
		{
			addEventListener(Event.ADDED_TO_STAGE, pcdrAddListeners);
		}
		if(_children)
		{
			children = new Vector<Panel>();
		}

		onTopOfMe = new Vector<Panel>();

		addEventListener(MouseEvent.MOUSE_DOWN, focus);
	}

	public function focus(e:MouseEvent):Void
	{
		if(parent!=null)
		{
			parent.addChild(this);
			var i:Int = onTopOfMe.length;
			while(i-->0)
			{
				if(parent.contains(onTopOfMe[i]))
				{
					parent.addChild(onTopOfMe[i]);
				}
			}
		}	
	}
	
	public function pcdrAddBackground(_width:Int = 300, _height:Int = 200, _borderFrame:Bool = true, _secondary:Bool = false):Void
	{
		background = new Sprite();
		var g:Graphics = background.graphics;

		if(_secondary == true)
		{
			g.beginFill(cast ToolkitEngine.settings.get("panel_color2"));
		}else
		{
			g.beginFill(cast ToolkitEngine.settings.get("panel_color"));
		}

		if(_borderFrame)
		{
			background.filters = [new GlowFilter(0x000000,1,15,15,1,10)];
		}
		g.drawRect(0,0,_width,_height);
		addChild(background);
	}

	public function pcdrAddTitleText(_title:String):Void
	{
		title = new TextField();
		title.defaultTextFormat = new TextFormat("courier new",12,cast ToolkitEngine.settings.get("text_color"),true);
		title.text = _title;
		title.height = 20;
		title.width = background.width;
		title.selectable = false;
		title.mouseEnabled = false;
		addChild(title);
	}

	public function pcdrSetUpExitButton():Void
	{
		exitButton = new Panel("X", 16,16,false,false,false,false,true);
		exitButton.x = background.width - 18;
		exitButton.y = 2;
		exitButton.addEventListener(MouseEvent.MOUSE_DOWN, exitButtonDown);
		addChild(exitButton);
	}

	public function pcdrAddListeners(e:Event):Void
	{
		background.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		background.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		removeEventListener(Event.ADDED_TO_STAGE, pcdrAddListeners);
	}

	public function mouseDown(e:MouseEvent):Void
	{
		startDrag();
	}

	public function mouseUp(e:MouseEvent):Void
	{
		stopDrag();
	}

	public function exitButtonDown(e:MouseEvent):Void
	{
		closeWindow();
	}

	public function stackSubPanel(_panel:Panel):Panel
	{
		children.push(_panel);

		if(stackMajorX +_panel.width + 10 > background.width)
		{
			stackMajorX = 10;
			stackMajorY += 30;
		}
		
		_panel.x = stackMajorX;
		_panel.y = stackMajorY;

		stackMajorX += Std.int(_panel.width) + 10;
		
		addChild(_panel);

		return _panel;
	}

	public function removePanel(_panel:Panel):Void
	{
		var i:Int = children.lastIndexOf(_panel);
		removeChild(children[i]);
		children[i] = children[children.length-1];
		children.length --;
	}

	public function closeWindow():Void
	{
		if(exitButton != null)
		{
			exitButton.removeEventListener(MouseEvent.MOUSE_DOWN, exitButtonDown);
		}
		
		removeEventListener(MouseEvent.MOUSE_DOWN, focus);

		if(children != null)
		{
			while(children.length != 0)
			{
				children[0].closeWindow();
			}
		}

		while(onTopOfMe.length!=0)
		{
			onTopOfMe.pop();
		}

		background.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		background.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		

		cast(parent,Panel).removePanel(this);
	}
}