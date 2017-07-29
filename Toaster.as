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

		}
		
	}
	
}
