package game.entities;
import flash.Vector;
import modules.TilemapModule;
import flash.geom.Point;
import tFramework.render.Pixie;
import tFramework.render.Sprodel;

/**
 * ...
 * @author TF
 */

class Swimmer extends Character
{

	public var speedh:Int;
	public var speedv:Int;
	private var drytimer:Int;
	
	public function new(mod:TilemapModule) 
	{
		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();
		var v2:Vector<String> = new Vector<String>();
		v.push(Vector.ofArray([new Point(0,3)]));
		v2.push("SWIM");
		var s:Sprodel = Global.enemysheet.toSprodel(v, v2);
		s.setState("SWIM");
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
		
		super(s, mod, w, h);
		
		speedv = speedh = 2;
		model.currentState.options.tickDelay = 5;
		drytimer = 0;
		velY = speedv;
	}
	
	override public function update():Void 
	{
		
		if (checkCollisionID(7, mod.map) == null)
		{
			drytimer++;
			velY += Global.GRAVITY;
		}
		else
		{
			drytimer = 0;
			if (flippedh) { velX = speedh; }
			else { velX = -speedh; }
		}
		
		if (drytimer >= 10)
		{
			velX *= Global.XFRICTION;
		}
		
		if (resting)
		{
			velY = -speedv;
		}
		
		
		solveMap(mod.map);
		
		if (velX == 0) { flippedh = !flippedh; }
	}
	
}