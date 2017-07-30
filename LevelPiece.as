package  {
	
	import com.gskinner.utils.Rndm;
	
	public class LevelPiece {

		public static const WIDTH:int = 10;
		public static const HEIGHT:int = 10;

		public var level:Level;
		public var x:int;
		public var y:int;

		public var map:Array;
		public var thingMap:Array;

		public var active:Boolean = false;

		public function LevelPiece(level:Level, x:int, y:int) {
			this.level = level;
			this.x = x;
			this.y = y;

			map = [];
			thingMap = [];

			for (var y:int = 0; y < HEIGHT; y ++) {
				map[y] = [];
				thingMap[y] = [];
				for (var x:int = 0; x < WIDTH; x ++) {
					map[y][x] = 0;
					thingMap[y][x] = null;

					if (Rndm.boolean(0.7)) {
						map[y][x] = 1;
					}

					if (Rndm.boolean(0.2)) {
						level.setThingAt(new Enemy(level), x, y);
					}
				}
			}
		}
	}
}