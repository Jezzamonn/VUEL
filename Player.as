package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class Player extends Thing {

		[Embed(source = "graphics/spritesheet.png")]
		private static const IMAGE_CLASS:Class;
		private static var _image:BitmapData;
		public static function get image():BitmapData {
			if (!_image) {
				_image = (new IMAGE_CLASS()).bitmapData;
			}
			return _image;
		}

		public function Player(level:Level) {
			super(level);


			moves = [
				{x:  0, y:  0},

				{x: -1, y:  0},
				{x:  1, y:  0},
				{x:  0, y: -1},
				{x:  0, y:  1},

				{x: -2, y:  0},
				{x:  2, y:  0},
				{x:  0, y: -2},
				{x:  0, y:  2},
			]
		}

		
		public override function renderSelf(context:BitmapData):void {
			//renderSquare(context, x, y, 0x009900, 1);
			context.copyPixels(image, new Rectangle(0, 0, 20, 20), new Point(x * Level.GRID_SIZE, y * Level.GRID_SIZE), null, null, true);
		}

		public override function renderMoves(context:BitmapData):void {
			for each (var move:* in moves) {
				if (level.validSquare(x + move.x, y + move.y)) {
					renderSquare(context, x + move.x, y + move.y, 0xFF00FF, 3)
				}
			}
		}

	}
	
}
