package  {
	
	public class Tv extends Enemy {

		public function Tv(level:Level) {
			super(level);

			renderOffset = 2;

			moves = [
				{x: 0, y: 0},

				{x:  2, y:  0},
				{x: -2, y:  0},
				//{x:  1, y:  0},
				//{x: -1, y:  0},
				{x:  0, y:  1},
				{x:  0, y: -1},
			];

			name = "TV";
			description = "Moves fast horizontally. Clever positioning can make these less threatening than they seem."
		}
		
	}
	
}
