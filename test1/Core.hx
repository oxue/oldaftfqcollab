package;
import editor.EditBuffer;
import editor.EditorCore;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.errors.Error;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.Vector;
import game.assets.Arrow;
import game.assets.Char;
import game.assets.Tiles;
import game.entities.Cannon;
import game.entities.Character;
import game.entities.Crate;
import game.entities.hud.Inventory;
import game.entities.Pacer;
import game.entities.Player;
import game.entities.Plushie;
import game.entities.Portal;
import game.entities.Shooter;
import io.EntFactory;
import io.PlayerInfo;
import libTF.utils.IntPoint;
import tFramework.core.units.Unit;
import tFramework.render.Sprodel;
import tFramework.render.Pixie;
import game.entities.Swimmer;
import game.terrainGeneration.TerrainGen;
import game.terrainGeneration.TerrainGenSettings;
import game.tiles.CheckpointTile;
import game.tiles.GrassTile;
import game.tiles.LadderTile;
import game.tiles.LauncherTile;
import game.tiles.LavaTile;
import game.tiles.OneWayTile;
import game.tiles.SignTile;
import io.MapSe;
import libTF.pRNGs.LinConPRNG;
import libTF.utils.IntRect;
import tFramework.render.RenderContext;
import game.tiles.MetalTile;
import game.tiles.AirTile;
import game.tiles.DirtTile1;
import libTF.utils.Fraction;
import libTF.utils.Point3D;
import libTF.dataStructures.Vector3D;
import libTF.dataStructures.Vector2D;
import flash.geom.Point;
import modules.MainMenuModule;
import modules.TilemapModule;
import tFramework.core.modules.Module;
import tFramework.render.TextBox;
import tFramework.render.Spritesheet;
import tFramework.tile.Tile;
import tFramework.tile.Tilemap;
import tFramework.render.Screen;
import flash.Lib;
import flash.utils.ByteArray;
import flash.net.FileReference;
import tFramework.core.Manager;
import libTF.utils.GlyphEncoder;
import haxe.Log;
import haxe.PosInfos;
import tFramework.tile.TileEntity;
import game.tiles.DirtTile2;
import game.tiles.RockTile1;
import tFramework.tile.Autotiler;
import libTF.dataStructures.Vector2D;
import game.tiles.WaterTile;
import game.tiles.BounceTile;
import game.entities.Jumper;
import game.entities.Flyer;
import tFramework.render.PixMap;
import tFramework.core.MouseManager;
import tFramework.core.KeyManager;
import flash.ui.Keyboard;
import tFramework.render.RenderContext;

class Core 
{

	private static var updateTime:String = " ";
	private static var renderTime:String = " ";
	private static var point:Point = new Point();
	
	inline public static function update():Void
	{
		var time:Int = Manager.time;
		
		var i:UInt = 0;
		while (i < Manager.modules.length)
		{
			Manager.modules[i].update();
			i++;
		}
		
		updateTime = "Update: " + Std.string(Manager.time - time) + "ms";
	}
	
	inline public static function render():Void
	{
		var time:UInt = Manager.time;
		
		var i:UInt = 0;
		while (i < Manager.modules.length)
		{
			Manager.modules[i].render(Screen.buffer, null);
			i++;
		}
		
		renderTime = "Render: " + Std.string(Manager.time - time) + "ms";
		
		point.y = 0;
		var infoBMD:BitmapData = GlyphEncoder.getString(updateTime, 0xFFFF00FF);
		Screen.buffer.copyPixels(infoBMD, infoBMD.rect, point);
		
		point.y = 10;
		var infoBMD:BitmapData = GlyphEncoder.getString(renderTime, 0xFFFF00FF);
		Screen.buffer.copyPixels(infoBMD, infoBMD.rect, point);
		
		Screen.flip();
	}
	
	public static function playLevel():Void
	{
		EntFactory.init();
		Manager.clearModules();
		var m:MapSe = new MapSe();
		var obj:Dynamic = {};
		obj.data = {};
		var tm:Tilemap = m.parsemap(EditorCore.encode(),obj);
		var tmd:TilemapModule = new TilemapModule(tm,tm, new IntRect(0, 0, Screen.buffer.width, Screen.buffer.height));
		Manager.addModule(tmd);

		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();
		var v2:Vector<String> = new Vector<String>();
		v.push(Vector.ofArray([new Point(0,0)]));
		v2.push("IDLE");
		v.push(Vector.ofArray([new Point(3,0)]));
		v2.push("JUMP");
		v.push(Vector.ofArray([new Point(1,0), new Point(2,0)]));
		v2.push("WALK");
		v.push(Vector.ofArray([new Point(6,0)]));
		v2.push("DIE");
		var s:Sprodel = Global.charsheet.toSprodel(v, v2);
		s.setState("IDLE");
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
			
		var char:Player = new Player(s, tmd, w, h);
		tmd.addUnit(char);
		char.x = char.y = 0;
		char.checkpoint = new Point(char.x, char.y);
		tmd.player = char;

		var i:Int = obj.data.entities.length;
		while(i-->0)
		{
			if (obj.data.entities[i].name == 'player')
			{
				char.x = obj.data.entities[i].x;
				char.y = obj.data.entities[i].y;
				char.velX = 0;
				char.velY = 0;
			}else {
			
			var u:Unit = EntFactory.get(obj.data.entities[i], [tmd]);
			tmd.addUnit(u);}
		}

		//tmd.portals.push(new Portal(tm,new IntPoint(3,2),0,1)); 
	}

	//inline public static function click
	
	public static function setState(s:String):Void
	{
		switch (s.toUpperCase())
		{
			case "START"://{
				Global.setup();
				Tile.init();
				//}

			case "TWO":
				Screen.setup(EditorCore.tmp.container, 2, 0x555555);

			case "INTRO"://{
				//TODO splash screens and such
				setState("EDITOR");
				//}
			case "MAIN MENU"://{
				Global.setup();
				Tile.init();
				Screen.setup(Manager.STAGE, 2, 0x555555);
				Manager.addModule(new MainMenuModule());
				//}

			case "EDITOR":
				Manager.clearModules();
				Core.playLevel();
				
			case "GAME"://{


			case "PAUSE"://{
				//MAYBE pause screen
				//}
		}
	}
	
}