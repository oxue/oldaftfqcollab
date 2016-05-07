package editor;

import flash.events.MouseEvent;
import tk.Button;

class EntButton extends Button
{
	public var ename:String;
	public var id:Int;

	public function new(_ename:String,_id:Int)
	{
		ename = _ename;
		id = _id;

		super(_ename, 160,20);
	}

	public override function mouseDown(e:MouseEvent):Void
	{
		super.mouseDown(e);
		EditorCore.selectedEnt = id;
	}
}