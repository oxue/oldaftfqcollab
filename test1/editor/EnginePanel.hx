package editor;

import editor.EditorCore;
import editor.TestMapPanel;
import tFramework.core.Manager;
import tFramework.render.Screen;
import tk.Button;
import tk.Panel;

class EnginePanel extends Panel
{
	public function new()
	{
		super("Engine",200,200);

		stackSubPanel(new Button("Start Engine",180,20,startEngine));
		stackSubPanel(new Button("Stop Engine",180,20,stopEngine));
	}

	public function startEngine():Void
	{
		Core.setState("EDITOR");
		EditorCore.mainPanel.addChild(EditorCore.tmp);
		EditorCore.tmp.visible = true;
	}

	public function stopEngine():Void
	{
		Manager.clearModules();
		EditorCore.tmp.visible = false;
	}
}