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

class Shot extends Projectile
{

	public function new(mod:TilemapModule) 
	{
		var v:Vector<Point> = new Vector<Point>();
		v.push(new Point(4, 2));
		v.push(new Point(5, 2));
		super(Global.enemysheet.toAnimation(v), mod, 16, 16);
		anim.options.paused = false;
		anim.options.looping = true;
		anim.options.tickDelay = 5;
	}
	
	override public function collide(col:CollisionData):Void 
	{
		mod.projectiles.splice(mod.projectiles.indexOf(this), 1);
	}
	
}