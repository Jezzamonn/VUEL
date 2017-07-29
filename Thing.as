package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class Thing {
		
		// In terms of the grid (?)
		public var x:int;
		public var y:int;
		
		public var map:Array;

		public function Thing() {
		}
		
		public function render(context:BitmapData):void {
			context.fillRect(new Rectangle(
				x * Level.GRID_SIZE + 1,
				y * Level.GRID_SIZE + 1,
				Level.GRID_SIZE - 2,
				Level.GRID_SIZE - 2), 0xFF00FF);
		}

	}
	
}
