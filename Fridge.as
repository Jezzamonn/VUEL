package  {
	
	public class Fridge extends Enemy {

		public function Fridge(level:Level) {
			super(level);

			renderOffset = 9;

			moves = [
				{x: 0, y: 0},

				{x:  1, y:  0},
				{x: -1, y:  0},
				{x:  0, y:  1},
				{x:  0, y: -1},
				
				{x:  1, y:  1},
				{x: -1, y:  1},
				{x:  1, y: -1},
				{x: -1, y: -1},
			];

			name = "Fridge";
			description = "Someone one left its door open and it never truly forgave them."
		}
		
	}
	
}
