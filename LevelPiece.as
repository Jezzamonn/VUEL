package  {
	
	public class LevelPiece {

		public static const WIDTH:int = 10;
		public static const HEIGHT:int = 10;

		public var map:Array;
		public var thingMap:Array;

		public var active:Boolean = false;

		public function LevelPiece() {
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
						addThing(new Enemy(this), x, y);
					}
				}
			}
		}
	}
}