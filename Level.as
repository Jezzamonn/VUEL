package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class Level {

		public static const GRID_SIZE:int = 20;
		
		public static const WIDTH:int = 10;
		public static const HEIGHT:int = 10;
		
		public var map:Array;

		public function Level() {
			// constructor code
			map = [];
			for (var y:int = 0; y < HEIGHT; y ++) {
				map[y] = [];
				for (var x:int = 0; x < WIDTH; x ++) {
					map[y][x] = null;
					if (Math.random() < 0.4) {
						var thing:Thing = new Thing();
						thing.x = x;
						thing.y = y;
						map[y][x] = thing;
					}
					else if (Math.random() < 0.05) {
						var player:Player = new Player();
						player.x = x;
						player.y = y;
						map[y][x] = player;
					}
				}
			}
		}
		
		public function render(context:BitmapData):void {
			var rect:Rectangle = new Rectangle(0, 0, GRID_SIZE, GRID_SIZE);
			for (var y:int = 0; y < HEIGHT; y ++) {
				rect.y = y * GRID_SIZE;
				for (var x:int = 0; x < WIDTH; x ++) {
					if (map[y][x]) {
						map[y][x].render(context);
					}
					//rect.x = x * GRID_SIZE;
					//var color:int = map[y][x] ? 0xFFFFFF : 0;
					//context.fillRect(rect, color);
				}
			}
		}

	}
	
}
