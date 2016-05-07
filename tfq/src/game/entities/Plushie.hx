package game.entities;

import flash.geom.Point;
import flash.Vector;
import flash.Vector;
import flash.Vector;
import flash.Vector;
import flash.Vector;
import libTF.utils.MathUtils;
import modules.TilemapModule;
import tFramework.render.Sprodel;
import tFramework.tile.Tilemap;
import tFramework.render.Pixie;
import libTF.utils.EtcUtils;

/**
 * ...
 * @author qwerber
 */

class Plushie extends Character
{
	private var facing:Int;
	private var wasResting:Bool;
	private var jumpTimer:Int;

	public function new(mod:TilemapModule) 
	{
		//TODO this kind of thing is too slow. make it a one-time
		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();//EtcUtils.ArrToVec2D ([[new Point(0, 5)], [new Point(1, 5), new Point(2, 5)]] );
		var v2:Vector<String> = new Vector<String>();//Vector.ofArray(["IDLE","JUMP"]);
		v.push(Vector.ofArray([new Point(0,5)]));
		v2.push("IDLE");
		v.push(Vector.ofArray([new Point(1,5), new Point(2,5)]));
		v2.push("JUMP");
		var s:Sprodel = Global.enemysheet.toSprodel(v, v2);
		s.setState("IDLE");
		s.getState("JUMP").options.looping = s.getState("JUMP").options.paused = false;
		s.getState("JUMP").options.tickDelay = 3;
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
		
		super(s, mod, w, h);
		
		jumpTimer = 0;
	}
	
	override public function update():Void
	{
		jumpTimer--;
		
		var dx:Float = mod.player.x - this.x;
		
		if (MathUtils.abs(dx) < 48 && jumpTimer <= 0 && resting && mod.player.y<this.y+10)
		{
			velY = -10;
			velX = MathUtils.sign(dx) * 2 * Global.XFRICTION;
			jumpTimer = 60;
			state = "JUMP";
			model.currentState.currentFrame = 1;
		}
		else if (resting)
		{
			velY = velX = 0;
			state = "IDLE";
		}
		
		if (velX > 0) { flippedh = true; }
		if (velX < 0) { flippedh = false; }
		
		velY += Global.GRAVITY;
		velY *= Global.YFRICTION;
		solveMap(mod.map);
		
		model.tick();
	}
	
}