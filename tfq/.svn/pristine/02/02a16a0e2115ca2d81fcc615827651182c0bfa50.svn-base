package editor;

import flash.display.Sprite;
import tFramework.core.Manager;
import tk.Panel;

class TestMapPanel extends Panel
{
	public var container:Sprite;

	public function new()
	{
		super("Engine",820,640);
		container = new Sprite();
		container.x = 10;
		container.y = 30;
		this.addChild(container);
	}

	public override function closeWindow():Void
	{
		Manager.clearModules();
		visible = false;
	}
}