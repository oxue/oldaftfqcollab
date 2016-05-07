package tFramework.tile;
import flash.Vector;
import game.tiles.LavaTile;
import game.tiles.WaterTile;

/**
 * ...
 * @author TF
 */

class Autotiler 
{	
	
	/* #  = LRUD
	 * ---------
	 * 0  = 0000
	 * 1  = 0001
	 * 2  = 0010
	 * 3  = 0011
	 * 4  = 0100
	 * 5  = 0101
	 * 6  = 0110
	 * 7  = 0111
	 * 8  = 1000
	 * 9  = 1001
	 * 10 = 1010
	 * 11 = 1011
	 * 12 = 1100
	 * 13 = 1101
	 * 14 = 1110
	 * 15 = 1111
	 */
	
	public static function watertile(map:Tilemap):Void
	{
		var m:Tile;
		var i:Int;
		var j:Int;
		var k:Int;
		var g:Int;
		
		//evaluate main blocks
		i = Std.int(map.tileRect.width);
		while (i-- != 0)
		{
			j = Std.int(map.tileRect.height);
			while (j-- != 0)
			{
				m = map.get(i, j);
				if (m.ID == 7)
				{
					//MAYBE change tilemap to a gridmap, use links
					var t:WaterTile = cast(m, WaterTile);
					t.top = (map.get(i, j - 1)).ID == 0;
				}
				else if (m.ID == 17)
				{
					var t:LavaTile = cast(m, LavaTile);
					t.top = (map.get(i, j - 1)).ID == 0;
				}
			}
		}
	}
	 
	public static function autotile(map:Tilemap):Void
	{
		var m:Tile;
		var i:Int;
		var j:Int;
		var k:Int;
		var g:Int;
		
		var l:Bool;
		var r:Bool;
		var u:Bool;
		var d:Bool;
		
		//evaluate main blocks
		i = map.tileRect.width;
		while (i-- != 0)
		{
			j = map.tileRect.height;
			while (j-- != 0)
			{
				m = map.get(i, j);
				if (m.renderType == TileRenderType.AUTOTILE)
				{
					g = m.autogroup;
					
					l = (map.get(i - 1, j).autogroup != g) && (i != 0);
					r = (map.get(i + 1, j).autogroup != g) && (i != map.tileRect.width - 1);
					u = (map.get(i, j - 1).autogroup != g) && (j != 0);
					d = (map.get(i, j + 1).autogroup != g) && (j != map.tileRect.height - 1);
					
					m.autoIndex = (l?8:0) | (r?4:0) | (u?2:0) | (d?1:0);
				}
			}
		}
		/*
		//evaluate top/bottom edges
		i = Std.int(map.tileRect.width - 1);
		j = Std.int(map.tileRect.height - 1);
		while (i-- != 1)
		{
			m = map.get(i, 0);
			if (m.renderType == TileRenderType.AUTOTILE)
			{
				g = m.autogroup;
				
				l = (map.get(i - 1, 0).autogroup != g);
				r = (map.get(i + 1, 0).autogroup != g);
				d = (map.get(i, 1).autogroup != g);
				
				m.autoIndex = (l?8:0) | (r?4:0) | (d?1:0);
			}
			
			m = map.get(i, j);
			if (m.renderType == TileRenderType.AUTOTILE)
			{
				g = m.autogroup;
				
				l = (map.get(i - 1, j).autogroup != g);
				r = (map.get(i + 1, j).autogroup != g);
				u = (map.get(i, j-1).autogroup != g);
				
				m.autoIndex = (l?8:0) | (r?4:0) | (u?2:0);
			}
		}
		
		//evaluate left/right edges
		i = Std.int(map.tileRect.width - 1);
		j = Std.int(map.tileRect.height - 1);
		while (j-- != 1)
		{
			m = map.get(0, j);
			if (m.renderType == TileRenderType.AUTOTILE)
			{
				g = m.autogroup;
				
				r = (map.get(0 + 1, j).autogroup != g);
				u = (map.get(0, j - 1).autogroup != g);
				d = (map.get(0, j + 1).autogroup != g);
				
				m.autoIndex = (r?4:0) | (u?2:0) | (d?1:0);
			}
			
			m = map.get(i, j);
			if (m.renderType == TileRenderType.AUTOTILE)
			{
				g = m.autogroup;
				
				l = (map.get(i - 1, j).autogroup != g);
				u = (map.get(i, j - 1).autogroup != g);
				d = (map.get(i, j + 1).autogroup != g);
				
				m.autoIndex = (l?8:0) | (u?2:0) | (d?1:0);
			}
		}
		
		//corners
			
		m = map.get(i, j);
		if (m.renderType == TileRenderType.AUTOTILE)
		{
			g = m.autogroup;
			
			l = (map.get(i - 1, j).autogroup != g);
			u = (map.get(i, j - 1).autogroup != g);
			d = (map.get(i, j + 1).autogroup != g);
			
			m.autoIndex = (l?8:0) | (u?2:0) | (d?1:0);
		}*/
	}
	
}