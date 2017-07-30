package  {
	
	public class Util {

		public static function absMod(x:int, y:int):int {
			var result = x % y;
			if (result < 0) result += y;
			return result;
		}

		public static function clamp(val:int, min:int, max:int):int {
			if (val < min) return min;
			if (val > max) return max;
			return val;
		}
	}
	
}
