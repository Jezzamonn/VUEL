package  {
	import flash.media.Sound;
	
	public class SoundManager {

		[Embed(source = "music/ld39.mp3")]
		private static const SONG_CLASS:Class;
		
		private static var song:Sound;

		public static function init():void {
			song = new SONG_CLASS();
		}
		init();
		
		public static function play():void {
			song.play(51, int.MAX_VALUE);
		}

	}
	
}
