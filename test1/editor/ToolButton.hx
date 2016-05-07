package editor;

import editor.EditorCore;
import flash.ui.Mouse;
import tk.Button;
import tk.SimpleOut;

class ToolButton extends Button
{
	public var id:Int;
	public var cursor:String;

	public function new(_title:String, _id:Int, _cursor:String = null)
	{
		super(_title,20,20,select);
		id = _id;
		cursor = _cursor;
	}

	public function select():Void
	{
		EditorCore.selectedTool = id;
		SimpleOut.writeLn("you have selected tool number " + cast id);
		if(cursor!=null)
		{
			Mouse.cursor = cursor;
		}
	}
}