package tFramework.render;
import libTF.utils.IntRect;
import libTF.utils.MathUtils;

/**
 * ...
 * @author ...
 */

class Pixie implements Renderable
{

	public var source:Renderable;
	public var clipping:IntRect;
	private var context:RenderContext;
	
	public function new(source:Renderable, clipping:IntRect = null) 
	{
		this.source = source;
		this.clipping = clipping;
		context = new RenderContext();
	}
	
	public function render(map:PixMap, ctx:RenderContext):Void
	{
		if (clipping == null) { source.render(map, context); }
		
		context = ctx.clone();
		
		if (context.clipping == null) {context.clipping = clipping; }
		else
		{
			context.clipping = new IntRect(clipping.x + ctx.clipping.x, clipping.y + ctx.clipping.y);
			context.clipping.width = MathUtils.imin(ctx.clipping.x + ctx.clipping.width, clipping.width) - ctx.clipping.x;
			context.clipping.height = MathUtils.imin(ctx.clipping.y + ctx.clipping.height, clipping.height) - ctx.clipping.y;
		}
		
		if (context.clipping.width <= 0 || context.clipping.height <= 0) { return; }
		else { source.render(map, context); }
	}
	
}