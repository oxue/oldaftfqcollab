package modules;
import flash.errors.Error;
import flash.net.drm.DRMVoucherDownloadContext;
import flash.utils.TypedDictionary;
import flash.Vector;
import game.entities.Character;
import game.entities.Item;
import game.entities.Player;
import game.entities.Portal;
import game.entities.Projectile;
import tFramework.core.controllers.Controller;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.Renderable;
import tFramework.render.RenderContext;
import tFramework.core.modules.Module;
import tFramework.tile.Tile;
import tFramework.tile.Tilemap;
import tFramework.tile.TileEntity;
import libTF.utils.IntRect;
import tFramework.render.Screen;

class TilemapModule extends Module
{
	
	public var view:IntRect;
	
	public var map:Tilemap;
	public var map2:Tilemap;
	
	public var characters:Vector<Character>;
	public var items:Vector<Item>;
	
	public var player:Player;
	
	public var tview:IntRect;
	
	public var projectiles:Vector<Projectile>;

	public var portals:Vector<Portal>;
	
	public function new(map:Tilemap, map2:Tilemap, view:IntRect) 
	{
		super();
		
		this.map = map;
		this.map2 = map2;
		
		characters = new Vector<Character>();
		items = new Vector<Item>();
		projectiles = new Vector<Projectile>();
		portals = new Vector<Portal>();
		
		this.view = view;
	}
	
	override public function update():Void 
	{
		super.update();
		
		var i:Int = 0;
		while (i < Std.int(characters.length))
		{
			characters[i].update();
			i++;
		}
		i = Std.int(items.length);
		while (i-->0)
		{
			//TODO no remove vars dang it
			//TODO switch to linked lists
			if (items[i].remove == true)
			{
				items[i] = items[items.length - 1];
				items.pop();
				continue;
			}
			items[i].update();
		}
		i = Std.int(projectiles.length);
		while (i-->0)
		{
			//TODO this line should be unnecessary. Find the cause of the problem so it can be removed.
			if (i > projectiles.length - 1) { continue; }
			if (projectiles[i].hitEntity(player))
			{
				player.death();
				projectiles.splice(i,1);
			}
			else
			{
				projectiles[i].update();
			}
		}
		
		map.update(tview);
		map2.update(tview);
		
		if (!player.dead)
		{
			view.x = Std.int(player.x - Screen.buffer.width/2);
			view.y = Std.int(player.y - Screen.buffer.height/2);
		}
	}
	
	override public function render(map:PixMap, context:RenderContext):Void
	{
		
		//render map
		if (view.x < 0) { view.x = 0; }
		if (view.y < 0) { view.y = 0; }
		if (view.x > this.map.width * this.map.tileSize - view.width) { view.x = this.map.width * this.map.tileSize - view.width; }
		if (view.y > this.map.height * this.map.tileSize - view.height) { view.y = this.map.height * this.map.tileSize - view.height; }
		var offx:Int = Std.int(view.x % 16);
		var offy:Int = Std.int(view.y % 16);
		tview = new IntRect(Std.int(view.x / 16), Std.int(view.y / 16), Std.int(view.width / 16) + 1, Std.int(view.height / 16) + 1);
		this.map2.blitDirect(map, -offx, -offy, tview);
		
		//TODO HORRIBLE AAAAH
		if (context == null) { context = new RenderContext();}
		if (view.x > 0) { context.x -= view.x; }
		if (view.y > 0) { context.y -= view.y; }
		
		
		var i:Int = 0;
		while (i < Std.int(characters.length))
		{
			if (!characters[i].dead)
			{
				characters[i].render(map, context);
			}
			i++;
		}
		
		i = 0;
		while (i < Std.int(items.length))
		{
			items[i].render(map, context);
			i++;
		}
		
		i = 0;
		while (i < Std.int(projectiles.length))
		{
			projectiles[i].render(map, context);
			i++;
		}
		i=0;
		while(i<Std.int(portals.length))
		{
			portals[i].render(map,context);
			i++;
		}
		
		super.render(map, context);
		
		//TODO fix this junk
		//this.map.render(view);
		//this.map.blitFromCache(map, 0, 0, view);
		this.map.blitDirect(map, -offx, -offy, tview);
		
		//TODO more layers
		
		i = 0;
		while (i < Std.int(characters.length))
		{
			if (characters[i].dead)
			{
				characters[i].render(map, context);
			}
			i++;
		}
	}
	
	override public function addUnit(unit:Unit):Void 
	{
		if (Std.is(unit, Item))
		{
			items.push(cast(unit,Item));
		}
		else if (Std.is(unit, Character))
		{
			characters.push(cast(unit,Character));
		}
		else if (Std.is(unit, Projectile))
		{
			projectiles.push(cast(unit,Projectile));
		}
		else
		{
			super.addUnit(unit);
		}
	}
	
	override public function removeUnit(unit:Unit):Void 
	{
		if (Std.is(unit, Item))
		{
			items.splice(items.indexOf(cast(unit,Item)), 1);
		}
		else if (Std.is(unit, Character))
		{
			characters.splice(characters.indexOf(cast(unit,Character)), 1);
		}
		else if (Std.is(unit, Projectile))
		{
			projectiles.splice(projectiles.indexOf(cast(unit,Projectile)), 1);
		}
		else
		{
			super.removeUnit(unit);
		}
	}
	
}