package  {
	import flash.media.Sound;
	
	public class SoundManager {

		[Embed(source = "music/ld39.mp3")]
		private static const SONG_CLASS:Class;

		[Embed(source = "music/splode.mp3")]
		private static const SPLODE_CLASS:Class;
		
		[Embed(source = "music/hop.mp3")]
		private static const HOP_CLASS:Class;
		
		private static var song:Sound;

		private static var sounds:Object;

		public static function init():void {
			song = new SONG_CLASS();
			
			sounds = {};

			for each (var soundName:* in ["hop", "splode"]) {
				var clazz:Class = SoundManager[soundName.toUpperCase() + "_CLASS"];
				sounds[soundName] = new clazz();
			}
		}
		
		public static function playSong():void {
			song.play(51, int.MAX_VALUE);
		}
		
		public static function playSound(name:String):void {
			sounds[name].play();
		}

	}
	
}
