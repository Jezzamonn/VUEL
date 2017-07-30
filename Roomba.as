package  {
	
	public class Roomba extends Enemy {

		public function Roomba(level:Level) {
			super(level);

			renderOffset = 7;

			moves = [
				{x: 0, y: 0},

				{x:  1, y:  1},
				{x: -1, y:  1},
				{x:  1, y: -1},
				{x: -1, y: -1},
			];

			name = "Roomba"
			description = "Decades of cleaning dust and hair has filled this roomba with malice. Has a penchant for diagonals."

		}
		
	}
	
}
