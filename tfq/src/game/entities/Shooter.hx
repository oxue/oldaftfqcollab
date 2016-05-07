package game.entities;
import tFramework.render.RenderContext;
import flash.Vector;
import modules.TilemapModule;
import flash.geom.Point;
import tFramework.render.PixMap;
import tFramework.render.Pixie;
import tFramework.render.Sprodel;

/**
 * ...
 * @author TF
 */

class Shooter extends Character
{

	private var shoottimer:Int;
	public var shootwait:Int;
	public var shootforce:Int;
	
	public function new(mod:TilemapModule) 
	{
		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();
		var v2:Vector<String> = new Vector<String>();
		v.push(Vector.ofArray([new Point(0,2)]));
		v2.push("IDLE");
		v.push(Vector.ofArray([new Point(0,2), new Point(1,2), new Point(2,2)]));
		v2.push("SHOOT");
		var s:Sprodel = Global.enemysheet.toSprodel(v, v2);
		s.setState("IDLE");
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
		
		super(s, mod, w, h);
		
		shoottimer = 0;
		shootwait = 60;
		shootforce = 3;
	}
	
	override public function update():Void 
	{
		flippedh = mod.player.x > x;
		
		shoottimer++;
		
		if (shoottimer > shootwait)
		{
			shoottimer = 0;
			var shot:Shot = new Shot(mod);
			shot.reposition((flippedh?9: -5) + x, y + 4);
			shot.velX = shootforce * (flippedh?1: -1);
			shot.flippedh = flippedh;
			mod.addUnit(shot);
			state = "SHOOT";
			model.currentState.options.paused = false;
			model.currentState.currentFrame = 0;
			model.currentState.options.tickDelay = 3;
		}
		else if (model.currentState.currentFrame == Std.int(model.currentState.frames.length) - 1 && state != "IDLE" )
		{
			state = "IDLE";
		}
		
		velY += Global.GRAVITY;
		velY *= Global.YFRICTION;
		
		solveMap(mod.map);
		
		model.tick();
	}
	
}