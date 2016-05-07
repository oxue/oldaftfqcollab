package editor;
import flash.Vector;
import flash.Vector;
import flash.Vector;
import game.tiles.AirTile;
import tk.Button;
import tk.Panel;

/**
 * ...
 * @author worldedit
 */

class LayersPanel extends Panel
{
	
	private var layers:Vector<Tilemap>;
	private var buttons:Vector<LayerButton>;
	private var addButton:Button;
	private var dataLayers:Vector<Vector<Vector<Int>>>;
	
	public var selectedLayer:LayerButton;
	
	public function new(_layers:Vector<Tilemap>, _data:Vector<Vector<Vector<Int>>>) 
	{
		super("Layers", 200, 200, true, true, true, true, false);
		layers = _layers;
		dataLayers = _data;
		buttons = new Vector<LayerButton>();
		var i:Int = layers.length;
		
		addButton = new Button("+", 20, 20, addLayer);
		stackSubPanel(addButton);
		addButton.x = 170;
		addButton.y = 30;
		
		while (i-->0)
		{
			var lbtn:LayerButton = new LayerButton(layers[i]);
			lbtn.data = dataLayers[i];
			stackSubPanel(lbtn);
			lbtn.x = 10;
			lbtn.y = 30 + i * 20;
			selectedLayer = lbtn;
			lbtn.setEditLayer();
		}
	}
	
	private function addLayer() 
	{
		var cb:EditBuffer = EditorCore.currBuffer;
		cb.layers.push(new Tilemap(cb.displayTilemap.graphic,cb.displayTilemap.mapWidth,cb.displayTilemap.mapHeight,cb.displayTilemap.tilesize));
		var v:Vector<Vector<Int>> = new Vector<Vector<Int>>(cb.displayTilemap.mapHeight,true);
		var i:Int = cb.displayTilemap.mapHeight;
		while (i-->0)
		{
			v[i] = new Vector<Int>(cb.displayTilemap.mapWidth, true);
		}
		cb.dataLayers.push(v);
		var lbtn:LayerButton = new LayerButton(cb.layers[cb.layers.length - 1]);
		lbtn.data = v;
		stackSubPanel(lbtn);
		lbtn.y = layers.length * 20 + 30;
		lbtn.x = 10;
		lbtn.setEditLayer();
		selectedLayer = lbtn;
		buttons.push(lbtn);
	}
	
}