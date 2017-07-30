package  {
	
	public class Drone extends Enemy {

		public function Drone(level:Level) {
			super(level);

			renderOffset = 8;

			moves = [
				{x: 0, y: 0},

				{x:  1, y:  1},
				{x: -1, y:  1},
				{x:  1, y: -1},
				{x: -1, y: -1},

				{x:  2, y:  2},
				{x: -2, y:  2},
				{x:  2, y: -2},
				{x: -2, y: -2},
			];

			name = "Drone";
			description = "Fast. Deadly. Fighting for survival comes naturally to this guy."
		}
		
	}
	
}
