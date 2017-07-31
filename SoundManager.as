package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	
	public class SoundManager {

		[Embed(source = "music/ld39.mp3")]
		private static const SONG_CLASS:Class;
		[Embed(source = "music/beat.mp3")]
		private static const BEAT_CLASS:Class;
		[Embed(source = "music/bitcrush.mp3")]
		private static const BITCRUSH_CLASS:Class;

		[Embed(source = "music/splode.mp3")]
		private static const SPLODE_CLASS:Class;
		
		[Embed(source = "music/hop.mp3")]
		private static const HOP_CLASS:Class;

		private static var sounds:Object;

		private static var curSong:Sound;
		private static var soundChannel:SoundChannel;

		public static function init():void {
			sounds = {};

			for each (var soundName:* in ["hop", "splode", "song", "beat", "bitcrush"]) {
				var clazz:Class = SoundManager[soundName.toUpperCase() + "_CLASS"];
				sounds[soundName] = new clazz();
			}
		}
		
		public static function startSong():void {
			curSong = sounds["beat"];
			soundChannel = curSong.play(51, int.MAX_VALUE);
		}

		public static function onSongRepeat(evt:Event = null):void {
			evt.currentTarget.removeEventListener(Event.SOUND_COMPLETE, onSongRepeat);
			soundChannel = curSong.play(51, int.MAX_VALUE);
		}

		public static function setSong(name:String):void {
			curSong = sounds[name];
			var pos:int = soundChannel.position;
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSongRepeat);
			soundChannel.stop();
			if (name == "beat") {
				pos %= 7111; // have to make it smaller to fit
			}
			soundChannel = curSong.play(pos);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSongRepeat);
		}
		
		public static function playSound(name:String):void {
			sounds[name].play();
		}

	}
	
}
