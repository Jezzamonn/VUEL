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
			if (player.power >= 3) {
				rect.x = 0 * rect.width;
			}
			else if (player.power == 2) {
				rect.x = 1 * rect.width;
			}
			else if (player.power == 1) {
				rect.x = 2 * rect.width;
			}
			else if (player.power <= 0) {
				rect.x = 3 * rect.width;
			}
			context.copyPixels(image, rect, point, null, null, true);
		}

	}

}