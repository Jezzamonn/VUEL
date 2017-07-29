package  {
	
	public class Duck extends Enemy {

		public function Duck(level:Level) {
			super(level);

			renderOffset = 3;

			moves = [
				{x: 0, y: 0},

				{x:  1, y:  2},
				{x: -1, y:  2},
				{x:  1, y: -2},
				{x: -1, y: -2},
				
				{x:  2, y:  1},
				{x:  2, y: -1},
				{x: -2, y:  1},
				{x: -2, y: -1},
			];

		}
		
	}
	
}
