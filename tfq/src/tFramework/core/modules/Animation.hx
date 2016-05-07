package tFramework.core.modules;
import tFramework.tile.SpriteAnim;

class Animation extends Module
{
	private var anim:SpriteAnim;
	
	public function new(anim:SpriteAnim, looping:Bool = false, start:Int = 0, end:Int = -1)
	{
		if (end == -1) { end = anim.finalFrame; }
		else if (end < 0) { end = 0; }
		if (start < 0) { start = 0; }
		
		this.anim = anim;
		this.anim.currentFrame = start;
		this.anim.paused = false;
	}
	
}