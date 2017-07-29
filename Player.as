package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class Player extends Thing {

		[Embed(source = "graphics/spritesheet.png")]
		private static const IMAGE_CLASS:Class;
		private static var image:BitmapData;

		public function Player() {
			if (!image) {
				image = (new IMAGE_CLASS()).bitmapData;
			}

			moves = [
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

		
		public override function render(context:BitmapData):void {
			renderSquare(context, x, y, 0x009900, 1);
			context.copyPixels(image, new Rectangle(0, 0, 20, 20), new Point(x * Level.GRID_SIZE, y * Level.GRID_SIZE), null, null, true);
			renderMoves(context, 0x00FF00);
		}

	}
	
}
