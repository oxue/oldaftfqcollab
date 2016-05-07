package libTF.collision;
import libTF.utils.IntRect;

/**
 * ...
 * @author TF
 */

class HitRect extends IntRect implements HitArea
{
	
	public function collidePoint(x:Float, y:Float)
	{
		return !(x < this.x || y < this.y || x > this.x + width || y > this.y + height);
	}
	
}