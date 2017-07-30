package  {
	
	public class Toaster extends Enemy {

		public function Toaster(level:Level) {
			super(level);

			renderOffset = 5;

			moves = [
				{x: 0, y: 0},

				{x: -1, y: -1},
				{x:  1, y: -1},
				{x:  0, y:  1},
			];

			name = "Toaster";
			description = "Tends to get stuck in small places, like the very toast it once used to create."
		}
		
	}
	
}
