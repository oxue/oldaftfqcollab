package editor;

import editor.ToolButton;
import tk.Button;
import tk.Panel;

class ToolBox extends Panel
{


	public function new()
	{
		super("Tool Box",200 ,90);
		stackSubPanel(new ToolButton("BR",0,'arrow'));
		stackSubPanel(new ToolButton("[]",1,'rect'));
		stackSubPanel(new ToolButton("ER",2));
		stackSubPanel(new ToolButton("+",3));
		stackSubPanel(new ToolButton("/",4));
		stackSubPanel(new ToolButton("EN",5));
		stackSubPanel(new ToolButton("SL",6));
	}
}