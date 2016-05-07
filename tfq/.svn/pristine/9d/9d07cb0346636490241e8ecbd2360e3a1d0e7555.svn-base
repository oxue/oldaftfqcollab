package game.entities;
import flash.Vector;
import modules.TilemapModule;
import tFramework.tile.CollisionData;
import tFramework.render.Animation;
import flash.geom.Point;

/**
 * ...
 * @author ...
 */

class Cannonball extends Projectile
{

	public function new(mod:TilemapModule) 
	{
		var v:Vector<Point> = new Vector<Point>();
		v.push(new Point(1, 6));
		super(Global.enemysheet.toAnimation(v), mod, 16, 16);
		anim.options.paused = true;
	}
	
	override public function update():Void 
	{
		solveMap(mod.map);
		velY += Global.GRAVITY;
	}
	
	override public function collide(col:CollisionData):Void 
	{
		mod.projectiles.splice(mod.projectiles.indexOf(this), 1);
	}
	
}