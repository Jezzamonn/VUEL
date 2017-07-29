package  {
	import com.gskinner.utils.Rndm;
	
	public class RndmUtil {

		public static function pickRandom(arr:Array):* {
			return arr[Rndm.integer(arr.length)];
		}

	}

}