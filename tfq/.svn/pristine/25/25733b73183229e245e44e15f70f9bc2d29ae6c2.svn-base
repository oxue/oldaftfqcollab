package editor;

import tk.Panel;
import tk.Button;

class Menu extends Panel
{
	public var fileMenu:Panel;
	public var viewMenu:Panel;

	public function new()
	{
		super("Menu",35,600,false);
		fileMenu = new Panel("Fl",25, 160, false, false, true, true, false);
		stackSubPanel(fileMenu);
		fileMenu.x = 5;
		fileMenu.y = 30;
		var b:Panel;
		b = fileMenu.stackSubPanel(new Button("Ne",20,20,newFunc));
		b.x = 2;
		b.y = 30;
		b = fileMenu.stackSubPanel(new Button("Op",20,20, openFunc));
		b.x = 2;
		b.y = 60;
		b = fileMenu.stackSubPanel(new Button("Sv",20,20,saveFunc));
		b.x = 2;
		b.y = 90;

		viewMenu = new Panel("Ve",25,160,false,false,true,true,false);
		stackSubPanel(viewMenu);
		viewMenu.x = 5;
		viewMenu.y = fileMenu.y + fileMenu.height + 10;
		b = viewMenu.stackSubPanel(new Button("Tb",20,20));
		b.x = 2;
		b.y = 30;
		b = viewMenu.stackSubPanel(new Button("Op",20,20));
		b.x = 2;
		b.y = 60;
		b = viewMenu.stackSubPanel(new Button("Pl",20,20));
		b.x = 2;
		b.y = 90;
	}

	public function newFunc()
	{
		EditorCore.newBuffer();
	}

	public function saveFunc()
	{
		EditorCore.saveMap();
	}

	public function openFunc()
	{
		EditorCore.openBuffer();
	}
}