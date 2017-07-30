package  {
	
	public class Battery extends Enemy {

		public function Battery(level:Level) {
			super(level);

			renderOffset = 4;

			name = "Battery";
			description = "Grab this for power! The one thing in this game that won't kill you. But it would if it could."
		}

		public override function pickMove():Object {
			return null;
		}
		
	}
	
}
