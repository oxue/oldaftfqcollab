package tFramework.tile;

class CollisionData 
{
	public static inline var HORIZONTAL:Int = 0;
	public static inline var VERTICAL:Int = 1;
	
	public var hit:Bool;
	public var entity:TileEntity;
	public var tile:Tile;
	public var x:Int;
	public var y:Int;
	public var time:Float;
	public var side:Int;
	
	
	//time = -1 -> no hit
	public function new(entity:TileEntity, tile:Tile, x:Int = 0, y:Int = 0, time:Float = -1, side:Int = 0) 
	{
		
		this.hit = (time != -1);
		this.entity = entity;
		this.tile = tile;
		this.x = x;
		this.y = y;
		this.time = time;
		this.side = side;
	}
	
}