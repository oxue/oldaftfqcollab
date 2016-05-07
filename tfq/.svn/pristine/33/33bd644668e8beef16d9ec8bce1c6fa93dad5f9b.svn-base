package sfbl.sys 
{
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class YAMLHelper 
	{
		private static var instance:YAMLHelper;
		
		public function YAMLHelper() 
		{
			
		}
		
		public static function getInstance():YAMLHelper
		{
			if (!instance)
			instance = new YAMLHelper();
			return instance;
		}
		
		public function vecToYAMLSeq2(v:Vector.<int>):String
		{
			var ret:String = "";
			ret += "[";
			ret += String(v[0]);
			var i:int = 0;
			var len:int = v.length - 1;
			while (i++ < len)
			{
				ret += "," + String(v[i]);
			}
			ret += "]";
			return ret;
		}
		
		public function pairToYAMLScal(name:String, data:*):String
		{
			var ret:String = "";
			ret += name;
			ret += ": "
			ret += String(data);
			ret += "\r\n";
			return ret;
		}
		
	}

}