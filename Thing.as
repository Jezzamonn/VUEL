package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class Thing {
		
		// In terms of the grid (?)
		public var x:int;
		public var y:int;
		
		// x y pairs
		public var moves:Array;

		public function Thing() {
			moves = [];
		}
		
		public function render(context:BitmapData):void {
			renderSquare(context, x, y, 0xFF00FF, 1)
		}

		public function renderSquare(context:BitmapData, x:int, y:int, color:int, edge:int = 0):void {
			context.fillRect(
				new Rectangle(
					x * Level.GRID_SIZE + edge,
					y * Level.GRID_SIZE + edge,
					Level.GRID_SIZE - 2 * edge,
					Level.GRID_SIZE - 2 * edge
				),
				color
			);
		}

		public function renderMoves(context:BitmapData, color:int):void {
			for each (var move:* in moves) {
				renderSquare(context, x + move.x, y + move.y, color, 3)
			}
		}

	}
	
}
