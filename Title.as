package  {
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class Title {

		[Embed(source = "graphics/title.png")]
		private static const IMAGE_CLASS:Class;
		private static var _image:BitmapData;
		public static function get image():BitmapData {
			if (!_image) {
				_image = (new IMAGE_CLASS()).bitmapData;
			}
			return _image;
		}
		
		public var clickToStart:TextBox;
		public var byMe:TextBox;
		
		public function Title() {
			clickToStart = new TextBox("nokia", Level.COLORS[3], 8, "center");
			clickToStart.textField.text = "CLICK TO START";
			clickToStart.x = 0;
			clickToStart.y = 0.75 * Main.HEIGHT;

			byMe = new TextBox("m3x6", Level.COLORS[2], 16, "center");
			byMe.textField.text = "A game made for LD39 by @jezzamonn";
			byMe.x = 0;
			byMe.y = Main.HEIGHT - byMe.textField.height;
		}
		
		public function update():void {
			
		}

		public function render(context:BitmapData):void {
			context.fillRect(context.rect, Level.COLORS[1])
			context.copyPixels(
				image,
				image.rect,
				new Point(
					0.5 * (Main.WIDTH - image.width),
					0.5 * (Main.HEIGHT - image.height)
				)
			);
			clickToStart.render(context);
			byMe.render(context);
		}

	}
	
}
