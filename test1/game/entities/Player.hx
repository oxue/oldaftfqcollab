package game.entities;

import flash.Vector;
import flash.geom.Point;
import game.entities.hud.Inventory;
import modules.TilemapModule;
import tFramework.render.Sprodel;
import tFramework.tile.CollisionData;
import tFramework.render.Spritesheet;
import tFramework.tile.Tile;
import tFramework.tile.Tilemap;
import tFramework.core.KeyManager;
import flash.ui.Keyboard;
import game.tiles.OneWayTile;
import game.tiles.LauncherTile;
import libTF.utils.MathUtils;
import game.tiles.CheckpointTile;
/**
 * ...
 * @author TF
 */

class Player extends Character
{
	//TODO revise player
	private var jumpforce:Float;
	private var walkspeed:Float;
	public var inventory:Inventory;
	private var deathtimer:Int;
	
	public var checkpoint:Point;
	
	public var thrustTimer:Int;
	private var thrustCap:Int;
	
	private var wasPressedZ:Bool;
	private var wasonladder:Bool;
	private var jumping:Bool;
	
	//require states: IDLE, WALK, JUMP, DIE
	public function new(model:Sprodel, mod:TilemapModule, width:Int, height:Int) 
	{
		super(model, mod, width, height);
		jumpforce = 6;
		walkspeed = 3;
		dead = false;
		checkpoint = new Point(0, 0);
		thrustTimer = 0;
		thrustCap = 3;
	}
	
	private inline function startJump()
	{
		jumping = true;
		thrustTimer = 0;
	}
	
	override public function update():Void
	{
		if (!dead)
		{
			var launched:CollisionData = checkCollisionID(11, mod.map2);
			var dirRestrict:CollisionData = checkCollisionID(10, mod.map);
			var underwater:Bool = checkCollisionID(7, mod.map) != null;
			var onladder:Bool = checkCollisionID(9, mod.map2) != null;
			var saveCollision:CollisionData = checkCollisionID(51, mod.map2);
			var saved:CheckpointTile = null;
			if (saveCollision != null) { saved = cast(saveCollision.tile, CheckpointTile);}
			
			var jmp:Float = jumpforce;
			var walk:Float = walkspeed;
			var xF:Float = Global.XFRICTION;
			var yF:Float = Global.YFRICTION;
			var g:Float = Global.GRAVITY;
			
			if (saved != null)
			{
				var CPTilespace = mod.map2.pToTilespace(checkpoint);
				var oldCPT:Tile = mod.map2.get(Std.int(CPTilespace.x), Std.int(CPTilespace.y));
				var oldCP:CheckpointTile = null;
				if (Std.is(oldCPT, CheckpointTile)) { oldCP = cast(oldCPT, CheckpointTile); }
				if (oldCP != null && oldCP != saved) { oldCP.on = false; }
				checkpoint = new Point(saveCollision.x, saveCollision.y);
				saved.on = true;
			}
			
			if (underwater)
			{
				xF *= .7;
				yF *= .9;
				jmp *= 1.2;
				g *= .3;
			}
			
			velY += g;
			
			if (onladder && ((!resting && wasonladder) || KeyManager.isPressed(Keyboard.UP) || KeyManager.isPressed(Keyboard.DOWN)))
			{
				//REVISE ugh was variables remove them
				wasonladder = true;
				velY = 0;
				if (KeyManager.isPressed(Keyboard.UP) /*|| KeyManager.isPressedStr("W")*/) { velY = -3; }
				if (KeyManager.isPressed(Keyboard.DOWN) /*|| KeyManager.isPressedStr("S")*/) { velY = 3; }
			}
			else
			{
				wasonladder = false;
			}
			
			
			if (KeyManager.isPressed(Keyboard.LEFT) /*|| KeyManager.isPressedStr("A")*/) { velX -= walk; flippedh = false; }
			else if (KeyManager.isPressed(Keyboard.RIGHT) /*|| KeyManager.isPressedStr("D")*/) { velX += walk; flippedh = true; }
			
			if (resting)
			{
				jumping = false;
			}
			
			if (!wasPressedZ && KeyManager.isPressedStr("Z") && resting)
			{
				startJump();
			}
			
			if (!KeyManager.isPressedStr("Z") && wasPressedZ)
			{
				jumping = false;
			}
			
			if (jumping && thrustTimer < thrustCap)
			{
				if (KeyManager.isPressedStr("Z"))
				{
					velY -= jmp/(thrustTimer+1);
					thrustTimer ++;
				}
			}
			
			wasPressedZ = KeyManager.isPressedStr("Z");
			
			velX *= xF;
			velY *= yF;
			
			if (!resting && state != "JUMP") { state = "JUMP"; model.currentState.options.tickDelay = 4; }
			else if (resting  && MathUtils.abs(velX) > .1 && state != "WALK") { state = "WALK"; model.currentState.options.tickDelay = 3; }
			else if (resting  && MathUtils.abs(velX) < .1 && state != "IDLE") { state = "IDLE"; }
			
			if (launched != null)
			{
				cast(launched.tile, LauncherTile).launch(this);
			}
			
			if (dirRestrict != null)
			{
				if (cast(dirRestrict.tile, OneWayTile).right && velX < 1) { velX = 1; }
				if (!cast(dirRestrict.tile, OneWayTile).right && velX > -1) { velX = -1; }
			}
			
			solveMap(mod.map);
			model.tick();
		
			if (KeyManager.isPressedStr("Q")) 
			{ 
				if (item == null) 
				{
					for (i in 0...mod.items.length)
					{
						if (hitEntity(mod.items[i])) { mod.items[i].grab(this); break; }
					}
				}
				else { item.velY = -10 + velY; item.velX = flippedh?10:-10 + velX; item.drop();}
			}
			for (i in 0...mod.characters.length)
			{
				if (mod.characters[i] != this && hitEntity(mod.characters[i])) { death(); break; }
			}
			
			if (checkCollisionID(17, mod.map) != null) { death(); }
		}
		else
		{
			velY += Global.GRAVITY;
			velY *= Global.YFRICTION;
			move();
			deathtimer++;
			if (deathtimer > 60)
			{
				respawn();
			}
		}
	}
	
	public function respawn():Void
	{
		dead = false;
		state = "IDLE";
		x = checkpoint.x;
		y = checkpoint.y - 8;
		velX = velY = 0;
	}
	
	public function death():Void
	{
		dead = true;
		state = "DIE";
		deathtimer = 0;
		velY = MathUtils.min(velY, -15);
	}
	
}