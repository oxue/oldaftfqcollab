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

class Flyer extends Character
{

	public var speed:Int;
	
	public function new(mod:TilemapModule) 
	{
		var v:Vector<Vector<Point>> = new Vector<Vector<Point>>();
		var v2:Vector<String> = new Vector<String>();
		v.push(Vector.ofArray([new Point(0,4)]));
		v2.push("FLY");
		var s:Sprodel = Global.enemysheet.toSprodel(v, v2);
		s.setState("FLY");
		var w:Int = cast(s.currentState.frames[0], Pixie).clipping.width;
		var h:Int = cast(s.currentState.frames[0], Pixie).clipping.height;
		
		super(s, mod, w, h);
		
		speed = 1;
		model.currentState.options.tickDelay = 5;
	}
	
	override public function update():Void 
	{
		if (flippedh) { velX = speed; }
		else { velX = -speed; }
		
		solveMap(mod.map);
		
		if (velX == 0) { flippedh = !flippedh; }
	}
	
}