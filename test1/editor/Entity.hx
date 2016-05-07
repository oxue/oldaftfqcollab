package editor;

import editor.CellMap;
import editor.Float2;
import flash.geom.Rectangle;

class Entity implements CellMapObject
{
	public var name:String;
	public var x:Int;
	public var y:Int;
	public var boundRect:Rectangle;
	public var bounds:Dynamic;
	public var marked:Bool;
	public var remove:Bool;
	public var radius2:Float;

	public var j:Int;
	public var i:Int;
	public var cm:CellMap;

	public function new(_name:String, _x:Int, _y:Int, _bounds:Dynamic)
	{
		bounds = _bounds;
		name = _name;
		x = _x;
		y = _y;
		if(_bounds!=null)
		{
			boundRect = new Rectangle(x + _bounds.left, y + _bounds.up, _bounds.right - _bounds.left, _bounds.down - _bounds.up);
		}
	}

	public function getPosition():Float2
	{
		return new Float2(x,y);
	}

	public function setIndexes(_j,_i,_cm):Void
	{
		j = _j;
		i = _i;
		cm = _cm;
	}

	public function removeFrom():Void
	{
		var v = cm.data.get(i).get(j);

		trace(v);

		var i = v.lastIndexOf(this);
		v[i] = v[v.length-1];
		v.length--;
	}
}