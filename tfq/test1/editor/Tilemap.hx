package editor;

import editor.CellMap;
import editor.Entity;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Vector;

class Tilemap 
{
	public var tilesize:Int;
	public var mapWidth:Int;
	public var mapHeight:Int;
	public var data:Vector<Vector<Int>>;
	public var tempRect:Rectangle;
	public var tempPoint:Point;
	public var tileGraphics:Vector<BitmapData>;
	public var entities:Vector<Entity>;
	public var tempEsRect:Rectangle;
	public var graphic:BitmapData;
	public var partionStruct:CellMap;
	public var stringName:String;
	
	public function new(_graphic:BitmapData, _mapWidth:Int, _mapHeight:Int, _tilesize:Int, defaultValue:Int = 17)
	{
		graphic = _graphic;
		mapWidth = _mapWidth;
		mapHeight = _mapHeight;
		tilesize = _tilesize;
		
		data = new Vector<Vector<Int>>(_mapHeight,true);
		var i:Int = _mapHeight;
		while(i-->0)
		{
			data[i] = new Vector<Int>(_mapWidth,true);
			var j:Int = _mapWidth;
			while(j-->0)
			{
				data[i][j] = defaultValue;
			}
		}

		tempPoint = new Point();
		tempRect = new Rectangle(0,0,tilesize,tilesize);

		tileGraphics = new Vector<BitmapData>(cast ((_graphic.width+1) * (_graphic.height+1) / ((tilesize + 1) * ((tilesize + 1)))),true);

		i = tileGraphics.length;

		entities = new Vector<Entity>();
		
		while(i-->0)
		{ 
			tileGraphics[i] = new BitmapData(tilesize,tilesize,true,0);
			tempRect.x = i % ((_graphic.width+1)/(tilesize + 1)) * (tilesize+1);
			tempRect.y = Std.int(i / ((_graphic.width+1)/(tilesize + 1)))* (tilesize+1);

			tileGraphics[i].copyPixels(_graphic, tempRect, tempPoint, null, null,true );
		}

		partionStruct = new CellMap(_mapWidth * _tilesize, _mapHeight * _tilesize, Std.int(_mapWidth * _tilesize / 50),Std.int(_mapHeight * _tilesize / 50));
	}

	public function addEntity(_e:Entity):Void
	{
		entities.push(_e);
		partionStruct.add(_e);	
	}

	public function render(_data:BitmapData, camera:Rectangle):Void
	{		
		var left:Int = Std.int(camera.x/tilesize);
		var right:Int = Std.int((camera.x + camera.width)/tilesize)+1;
		var up:Int = Std.int(camera.y/tilesize);
		var down:Int = Std.int((camera.y+camera.height)/tilesize)+1;

		if(left<0)
		left = 0;
		if(up<0)
		up = 0;
		if(right>mapWidth)
		right = mapWidth;
		if(down>mapHeight)
		down = mapHeight;

		var i:Int = down;
		while(i-->up)
		{
			var j:Int = right;
			while(j-->left)
			{
				var index:Int = data[i][j];
				tempPoint.x = j * tilesize - camera.x;
				tempPoint.y = i * tilesize - camera.y;
				_data.copyPixels(tileGraphics[index],tileGraphics[index].rect,tempPoint,null,null,true);
			}
		}

		i = entities.length;
		while(i-->0)
		{
			if(entities[i].remove)
			{
				entities[i] = entities[entities.length-1];
				entities.length--;
				continue;
			}
			tempPoint.x = entities[i].x - camera.x-8;
			tempPoint.y = entities[i].y - camera.y-8;
			tempEsRect = entities[i].boundRect.clone();
			tempEsRect.x -= camera.x;
			tempEsRect.y -= camera.y;
			var c = 0xffff0000;
			if(entities[i].marked)
			{
				c = 0xff660000;
			}
			_data.fillRect(tempEsRect,c);
			_data.copyPixels(EditorCore.entIcon,EditorCore.entIcon.rect,tempPoint,null,null,true);
		}
	}
}