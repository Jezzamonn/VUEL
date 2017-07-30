package  {

	import com.gskinner.utils.Rndm;
	
	public class Enemy extends Thing {

		public static function randomEnemy(level:Level):Enemy {
			var classes:Array = [
				Battery,
				Lamp,
				Tv,
				Toaster,
				Roomba,
				Duck
			];
			var clazz:Class = RndmUtil.pickRandom(classes);
			return new clazz(level);
		}

		public function Enemy(level:Level) {
			super(level);
		}
		
		public override function move():void {
			var xDiff:int = x - level.player.x;
			var yDiff:int = y - level.player.y;
			var dist:int = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
			if (dist > 7) { // don't move if too far away
				return;
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
			//trace(bestDist);
			if (bestMove) {
				moveTo(x + bestMove.x, y + bestMove.y);
			}
			else {
				// can't move??? Oh no
			}
		}

	}
	
}
