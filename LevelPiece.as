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

			gen();
		}
		
		public function gen():void {
			map = [];
			thingMap = [];
			
			for (var y:int = 0; y < HEIGHT; y ++) {
				map[y] = [];
				thingMap[y] = [];
				for (var x:int = 0; x < WIDTH; x ++) {
					map[y][x] = 0;
					thingMap[y][x] = null;

					if (Rndm.boolean(0.85)) {
						map[y][x] = 1;
					}
				}
			}
		}

		public function addThings():void {
			// difficulty = distance from start
			var dist:int = Math.abs(x) + Math.abs(y);
			var difficulty:int = Math.floor(dist * 0.4);

			var spawnChance:Number = 0.05 + 0.001 * dist;

			//trace("Difficulty: " + difficulty);
			//trace("Spawn Chance: " + spawnChance)

			for (var y:int = 0; y < HEIGHT; y ++) {
				for (var x:int = 0; x < WIDTH; x ++) {
					if (level.validSquare(this.x * WIDTH + x, this.y * HEIGHT + y) && Rndm.boolean(spawnChance)) {
						level.addThingAt(Enemy.randomEnemy(level, difficulty), this.x * WIDTH + x, this.y * HEIGHT + y);
					}
				}
			}
		}

		public function addSurroundingPieces():void {
			//trace("Add surrounding from (" + this.x + ", " + this.y + ")");
			for (var y:int = -1; y <= 1; y ++) {
				for (var x:int = -1; x <= 1; x ++) {
					if (x == 0 && y == 0) continue;

					if (!level.getPieceAtPieceCoord(this.x + x, this.y + y)) {
						level.addLevelPiece(this.x + x, this.y + y);
					}
				}
			}
		}
	}
}