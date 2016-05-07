package editor;

import flash.events.MouseEvent;
import flash.Vector;
import tk.Panel;
import tk.SlideBar;

class Entities extends Panel
{
	public var buttons:Vector<EntButton>;
	public var slider:SlideBar;

	public function new(_cfgString:String)
	{
		super("Entities",200,200);
		var cfg:Dynamic = flash.utils.JSON.parse(_cfgString);
		var i:Int = -1;
		buttons = new Vector<EntButton>();
		while(i++<cfg.entities.length-1)
		{
			var b:EntButton = new EntButton(cfg.entities[i].name, i);
			stackSubPanel(b);
			buttons.push(b);
			b.y = i * 20 + 30;
		}

		slider = new SlideBar(160,cast cfg.entities.length*20-150);
		slider.x = 190;
		slider.y = 30;
		slider.rotation = 90;
		addChild(slider);

		flash.Lib.current.parent.addEventListener(MouseEvent.MOUSE_MOVE, updatePos);
	}

	public function updatePos(e:MouseEvent):Void
	{
		var i:Int = buttons.length;
		while(i-->0)
		{
			buttons[i].y = i * 20 + 30 - slider.value;
			if(buttons[i].y < 30)
			{
				buttons[i].alpha = (buttons[i].y)/40;
			}else if(buttons[i].y >160)
			{
				buttons[i].alpha = (180 - buttons[i].y)/40;
			}else
			{
				buttons[i].alpha = 1;
			}
		}
	}
}