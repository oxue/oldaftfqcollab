package libTF.structures;
import flash.net.SharedObject;
import flash.Vector;

class SaveDataManager
{
	
	public var currentSave:SharedObject;
	private var saves:Vector<SharedObject>;
	private var version:Float;
	
	public function new(name:String, version:Float, numSlots:Int = 1, path:String = null)
	{
		target(name, version, numSlots, path);
	}
	
	public function target(name:String, version:Float, numSlots:Int = 1, path:String = null):Void
	{
		saves = new Vector<SharedObject>(numSlots);
		this.version = version;
		var i:Int = 0; 
		while (i < numSlots)
		{
			saves[i] = SharedObject.getLocal(name + "_" + i, path);
			if (!saves[i].data.version)
			{
				saves[i].data.version = 0;
			}
			i++;
		}
	}
	
	public function applyPatch(oldVer:Float, newVer:Float, patchFunc:Dynamic->Void):Void
	{
		var i:Int = 0;
		while (i < Std.int(saves.length) )
		{
			if ( saves[i].data.version == oldVer)
			{
				saves[i].data.version = newVer;
				patchFunc(saves[i].data);
			}
			i++;
		}
	}
	
	public function evaluateCurrent():Bool
	{
		var i:Int = 0;
		while ( i < Std.int(saves.length) )
		{
			if (saves[i].data.version!= version)
			{
				return false;
			}
			i++;
		}
		return true;
	}
	
	public function switchSlot(slot:Int):Void
	{
		if (slot < Std.int(saves.length))
		{
			currentSave.flush();
			currentSave = saves[slot];
		}
	}
	
	public function flushSOL():Void
	{
		currentSave.flush();
	}
	
	public function deleteSOL():Void
	{
		currentSave.clear();
		currentSave.flush();
		currentSave.close();
	}
	
	public function clearSlot():Void
	{
		currentSave.clear();
	}
	
	public function deleteAll():Void
	{
		var i:Int = 0; 
		while (i < Std.int(saves.length))
		{
			saves[i].clear();
			saves[i].flush();
			saves[i].close();
			i++;
		}
	}
	
	public function clearAll():Void
	{
		var i:Int = 0; 
		while (i < Std.int(saves.length))
		{
			saves[i].clear();
			i++;
		}
	}
	
}