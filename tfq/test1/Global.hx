package ;
import flash.display.Sprite;
import game.assets.Char;
import game.assets.Enemies;
import tFramework.render.PixMap;
import tFramework.render.Spritesheet;
import game.assets.Tiles;
import game.assets.Items;

/**
 * ...
 * @author TF
 */

 //For holding static variables that need to be accessed throughout the game.
class Global 
{
	inline public static var XFRICTION:Float = .7;
	inline public static var YFRICTION:Float = .99;
	inline public static var GRAVITY:Float = 1;
	
	public static var tilesheet:Spritesheet;
	public static var itemsheet:Spritesheet;
	public static var enemysheet:Spritesheet;
	public static var charsheet:Spritesheet;
	
	//REVISE questionable design-wise
	public static var crateImage:PixMap;

	public static function setup():Void
	{
		tilesheet = new Spritesheet(PixMap.fromBMD(new Tiles()), 16, 16, 1, 0);
		itemsheet = new Spritesheet(PixMap.fromBMD(new Items()), 16, 16, 1, 0);
		enemysheet = new Spritesheet(PixMap.fromBMD(new Enemies()), 16, 16, 1, 0);
		charsheet = new Spritesheet(PixMap.fromBMD(new Char()), 16, 24, 1, 0);
		
		crateImage = itemsheet.getBMDFromInd(0);
	}
	
}