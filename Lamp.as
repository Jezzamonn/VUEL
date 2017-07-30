package  {
	
	public class Lamp extends Enemy {

		public function Lamp(level:Level) {
			super(level);

			renderOffset = 6;

			moves = [
				{x: 0, y: 0},

				{x:  1, y:  0},
				{x: -1, y:  0},
				{x:  0, y:  1},
				{x:  0, y: -1},
			];

			name = "Lamp";
			description = "This internet-connected lamp has gone haywire since the WiFi went down. Moves steadily.";

		}
		
	}
	
}
