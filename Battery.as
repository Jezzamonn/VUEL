package  {
	
	public class Battery extends Enemy {

		public function Battery(level:Level) {
			super(level);

			renderOffset = 4;
		}

		public override function pickMove():Object {
			return null;
		}
		
	}
	
}
