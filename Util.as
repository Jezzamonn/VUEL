package  {
	
	public class Util {

		public static function absMod(x:int, y:int):int {
			var result = x % y;
			if (result < 0) result += y;
			return result;
		}
	}
	
}
