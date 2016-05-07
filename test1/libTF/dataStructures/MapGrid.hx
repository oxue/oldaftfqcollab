package libTF.dataStructures;
import libTF.utils.Vector2D;

class MapGrid<T> extends Vector2D<GridNode<T>>
{

	public function new(width:Int, height:Int, initVal:T = null)
	{
		super(width, height, null, false);
		var i:Int = 0;
		var j:Int;
		while (i < width)
		{
			j = 0;
			while (j < height)
			{
				j++;
				set(i, j, new GridNode<T>(initVal));
			}
			i++;
		}
		
		i = 0;
		while (i < width)
		{
			j = 0;
			while (j < height)
			{
				j++;
				var node:GridNode<T> = get(i, j);
				node.up = get(i, j-1);
				node.down = get(i, j+1);
				node.left = get(i-1, j);
				node.right = get(i + 1, j);
				node.x = i;
				node.y = j;
			}
			i++;
		}
	}
	
}