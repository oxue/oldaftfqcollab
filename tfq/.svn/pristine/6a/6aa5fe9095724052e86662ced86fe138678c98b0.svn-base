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

class Cannon extends Character
{

	private var shoottimer:Int;
	public var shootwait:Int;
	public var shootforceh:Int;
	public var shootforcev:Int;
	
	public function new(mod:TilemapModule) 
	{
		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();
		var v2:Vector<String> = new Vector<String>();
		v.push(Vector.ofArray([new Point(0,6)]));
		v2.push("SIT");
		var s:Sprodel = Global.enemysheet.toSprodel(v, v2);
		s.setState("SIT");
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
		
		super(s, mod, w, h);
		
		shoottimer = 0;
		shootwait = 60;
		shootforceh = 9;
		shootforcev = -9;
	}
	
	override public function update():Void 
	{
		shoottimer++;
		
		if (shoottimer > shootwait)
		{
			shoottimer = 0;
			var shot:Cannonball = new Cannonball(mod);
			shot.reposition(flippedh?(x+4):(x+6), y+6);
			shot.velX = shootforceh * (flippedh?1: -1);
			shot.velY = shootforcev;
			mod.addUnit(shot);
		}
		
		velY += Global.GRAVITY;
		velY *= Global.YFRICTION;
		
		solveMap(mod.map);
	}
	
}