package  {
	import com.gskinner.utils.Rndm;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class BatteryIcon {

		[Embed(source = "graphics/battery.png")]
		private static const IMAGE_CLASS:Class;
		private static var _image:BitmapData;
		public static function get image():BitmapData {
			if (!_image) {
				_image = (new IMAGE_CLASS()).bitmapData;
			}
			return _image;
		}

		public var player:Player;

		public function BatteryIcon() {
		}

		public function render(context:BitmapData):void {
			var rect:Rectangle = new Rectangle(0, 0, 10, 18);
			var point:Point = new Point(3, 3);

			var displayedPower:int = Util.clamp(player.power, 0, 4);

			rect.x = (4 - displayedPower) * rect.width;
			context.copyPixels(image, rect, point, null, null, true);
		}

	}

}