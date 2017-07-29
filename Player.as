package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class Player extends Thing {
		
		public function Player() {
			moves = [
				{x: -1, y:  0},
				{x:  1, y:  0},
				{x:  0, y: -1},
				{x:  0, y:  1},

				{x: -2, y:  0},
				{x:  2, y:  0},
				{x:  0, y: -2},
				{x:  0, y:  2},
			]
		}

		
		public override function render(context:BitmapData):void {
			renderSquare(context, x, y, 0x009900, 1);
			renderMoves(context, 0x00FF00);
		}

	}
	
}
