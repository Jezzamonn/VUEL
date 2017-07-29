package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class Level {
		
		public static const WIDTH:int = 10;
		public static const HEIGHT:int = 10;
		
		public var map:Array;

		public function Level() {
			// constructor code
			map = [];
			for (var y:int = 0; y < HEIGHT; y ++) {
				map[y] = [];
				for (var x:int = 0; x < WIDTH; x ++) {
					map[y][x] = Math.floor(Math.random() * 2);
				}
			}
		}
		
		public function render(context:BitmapData):void {
			var gridSize:int = 10;
			var rect:Rectangle = new Rectangle(0, 0, gridSize, gridSize);
			for (var y:int = 0; y < HEIGHT; y ++) {
				rect.y = y * gridSize;
				for (var x:int = 0; x < WIDTH; x ++) {
					rect.x = x * gridSize;
					var color:int = map[y][x] ? 0xFFFFFF : 0;
					context.fillRect(rect, color);
				}
			}
		}

	}
	
}
