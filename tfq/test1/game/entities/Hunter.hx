package game.entities;
import modules.TilemapModule;

/**
 * ...
 * @author qwerber
 */

class Hunter extends Character
{
	
	private var walkingOn
	
	public function new(mod:TilemapModule) 
	{
		super(Global.enemysheet, mod, Vector.ofArray([new Point(2, 5)]), new Vector<Point>(), Vector.ofArray([new Point(0, 5)]), Vector.ofArray([new Point(0, 5)]));
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
}