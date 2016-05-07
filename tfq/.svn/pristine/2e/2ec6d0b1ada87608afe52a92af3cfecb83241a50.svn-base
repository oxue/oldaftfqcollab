package editor;

import editor.Float2;
import flash.utils.TypedDictionary;
import flash.Vector;

class CellMap
{
	private var colSize:Float;
	private var rowSize:Float;
	private var width:Int;
	private var height:Int;
	private var cols:Int;
	private var rows:Int;
	public var data:TypedDictionary<Int,TypedDictionary<Int,Vector<CellMapObject>>>;

	public function new(_width:Int,_height:Int,_cols:Int,_rows:Int)
	{
		width = _width;
		height = _height;
		cols = _cols;
		rows = _rows;
		colSize = width/cols;
		rowSize = width/rows;

		data = new TypedDictionary<Int,TypedDictionary<Int,Vector<CellMapObject>>>();
	}

	public inline function add(_o:CellMapObject):Void
	{
		var pos:Float2 = _o.getPosition();
		var gx:Int = Std.int(pos._0/colSize);
		var gy:Int = Std.int(pos._1/rowSize);

		if(data.get(gy) == null)
		{
			data.set(gy,new TypedDictionary<Int,Vector<CellMapObject>>());
			data.get(gy).set(gx,new Vector<CellMapObject>());
		}

		if(data.get(gy).get(gx) == null)
		{
			data.get(gy).set(gx, new Vector<CellMapObject>());
		}
		
		_o.setIndexes(gx,gy,this);

		data.get(gy).get(gx).push(_o);
	}

	public inline function mget(j:Int,i:Int):Vector<CellMapObject>
	{
		var term = data.get(i);
		var ret:Vector<CellMapObject>;
		ret = null;
		if(term!=null)
		{
			ret = term.get(j);
		} 
		return ret;
	}

	public inline function catList(j,i,ret):Vector<CellMapObject>
	{
		var c = mget(j,i);
		if(c!=null)
		{
			ret = c.concat(ret);
		}

		return ret;
	}

	public function get(_x:Float, _y:Float):Vector<CellMapObject>
	{
		var j:Int = Std.int(_x/colSize);
		var i:Int = Std.int(_y/rowSize);
		var ret:Vector<CellMapObject> = new Vector<CellMapObject>();
		var c:Vector<CellMapObject>;
		c = mget(j,i);
		if(c!=null)
		{
		ret = c.concat();
		}
		ret = catList(j-1,i,ret);
		ret = catList(j+1,i,ret);
		ret = catList(j-1,i+1,ret);
		ret = catList(j-1,i-1,ret);
		ret = catList(j,i+1,ret);
		ret = catList(j,i-1,ret);
		ret = catList(j+1,i+1,ret);
		ret = catList(j+1,i-1,ret);
		return ret;
	}
}