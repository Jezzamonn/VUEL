package  {

	import com.gskinner.utils.Rndm;
	
	public class Enemy extends Thing {

		public static function randomEnemy(level:Level, difficulty:int = 0):Enemy {
			var classes:Array = [
				[ // 0
					Battery,
					Battery,
					Lamp,
					Toaster,
					Tv,
					Roomba,
				],
				[ // 1
					Battery,
					Battery,
					Battery,
					Lamp,
					Lamp,
					Toaster,
					Toaster,
					Tv,
					Tv,
					Roomba,
					Roomba,
					Duck
				],
				[ // 2
					Battery,
					Battery,
					Lamp,
					Lamp,
					Toaster,
					Tv,
					Tv,
					Roomba,
					Roomba,
					Duck,
					Fridge
				],
				[ // 3
					Battery,
					Lamp,
					Toaster,
					Tv,
					Roomba,
					Duck,
					Duck,
					Fridge,
					Fridge,
					Drone
				],
				[ // 4
					Lamp,
					Tv,
					Roomba,
					Duck,
					Duck,
					Fridge,
					Fridge,
					Drone,
					Drone,
				]
			];
			if (difficulty > 4) {
				difficulty = 4;
			}
			var clazz:Class = RndmUtil.pickRandom(classes[difficulty]);
			return new clazz(level);
		}

		public function Enemy(level:Level) {
			super(level);
		}

		public override function makeMoveSound():void {
			var thing:Thing = replacingThing;
			if (thing && thing === level.player) {
				SoundManager.playSound("splode");
			}
			else {
				SoundManager.playSound("hop");
			}
		}
		
		public override function pickMove():Object {
			var xDiff:int = x - level.player.x;
			var yDiff:int = y - level.player.y;
			var dist:int = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
			if (dist > 7) { // don't move if too far away
				return null;
			}

			
			// greedy for the moment.
			var bestDist:int = int.MAX_VALUE;
			var bestMove:*;
			
			for each (var move:* in moves) {
				if (!level.validSquare(x + move.x, y + move.y) || level.hasEnemy(x + move.x, y + move.y, [level.player, this])) {
					continue;
				}
				// TODO: replace this with A* if I'm feeling super zealous
				// Use actual distance because it's a better metric with diagonal moves
				var xDiff:int = (x + move.x) - level.player.x;
				var yDiff:int = (y + move.y) - level.player.y;
				var dist:int = xDiff * xDiff + yDiff * yDiff;
				if (dist < bestDist) {
					bestDist = dist;
					bestMove = move;
				}
			}
			return bestMove;
		}

	}
	
}
