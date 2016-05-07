package editor;
import flash.events.MouseEvent;
import flash.text.TextFieldType;
import flash.Vector;
import tk.Button;

/**
 * ...
 * @author worldedit
 */

class LayerButton extends Button
{
	
	private var tilemap:Tilemap;
	public var data:Vector<Vector<Int>>;
	
	public function new(_tilemap:Tilemap, _name:String = "default") 
	{
		super(_name, 120, 20, setEditLayer);
		//this.mouseChildren = false;
		//this.doubleClickEnabled = true;
		//this.addEventListener(MouseEvent.DOUBLE_CLICK, dclick);
		tilemap = _tilemap;
		title.mouseEnabled = false;
	}
	
	public function changeTitle(_title:String):Void
	{
		tilemap.stringName = _title;
		title.text = _title;
	}
	
	private function dclick(e:MouseEvent):Void 
	{
		var tcf:LayerTitleForm = new LayerTitleForm(this);
		EditorCore.addPanel(tcf);
		tcf.x = tcf.y = 300;
	}
	
	public function deselect():Void
	{
		x -= 5;
	}
	
	public function setEditLayer() 
	{
		trace('asd');
		EditorCore.currBuffer.displayTilemap = this.tilemap;
		EditorCore.currBuffer.data = this.data;
		var l:LayersPanel = cast(parent, LayersPanel);
		l.selectedLayer.deselect();
		l.selectedLayer = this;
		x += 5;
	}
	
}