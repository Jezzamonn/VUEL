package  {
	
	public class Battery extends Enemy {

		public function Battery(level:Level) {
			super(level);

			renderOffset = 4;

			moves = [
				{x: 0, y: 0},
			];

		}
		
	}
	
}
