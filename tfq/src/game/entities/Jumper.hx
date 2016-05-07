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

class Jumper extends Character
{

	private var jumptimer:Int;
	public var jumpwait:Int;
	public var jumpforce:Int;
	
	public function new(mod:TilemapModule) 
	{
		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();
		var v2:Vector<String> = new Vector<String>();
		v.push(Vector.ofArray([new Point(0,1)]));
		v2.push("IDLE");
		v.push(Vector.ofArray([new Point(0,1), new Point(1,1), new Point(2,1), new Point(3,1)]));
		v2.push("JUMP");
		var s:Sprodel = Global.enemysheet.toSprodel(v, v2);
		s.setState("IDLE");
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
		
		super(s, mod, w, h);
		
		jumptimer = 0;
		jumpwait = 60;
		jumpforce = -15;
	}
	
	override public function update():Void 
	{
		jumptimer++;
		if (jumptimer > jumpwait)
		{
			jumptimer = 0;
			velY = jumpforce;
			state = "JUMP";
			model.currentState.options.paused = false;
			//trace(anim.frames.length);
			//anim.tickDelay = 1;
			model.currentState.options.tickDelay = 3;
		}
		else if (resting )
		{
			state = "IDLE";
		}
		
		velY += Global.GRAVITY;
		velY *= Global.YFRICTION;
		
		solveMap(mod.map);
	}
	
}