package  {
	import com.gskinner.utils.Rndm;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class Thing {

		public var level:Level;
		
		// In terms of the grid (?)
		public var x:int;
		public var y:int;
		
		// x y pairs
		public var moves:Array;

		public var power:int;

		public var active:Boolean = false;

		public function Thing(level:Level) {
			this.level = level;

			moves = [
				{x: 0, y: 0},

				{x: -1, y:  0},
				{x:  1, y:  0},
				{x:  0, y: -1},
				{x:  0, y:  1}
			];
		}

		public function move():void {
			var movesCopy:Array = moves.slice();
			while (movesCopy.length > 0) {
				var rIndex:int = Rndm.integer(movesCopy.length);

				var move:Object = movesCopy[rIndex];
				if (level.validSquare(x + move.x, y + move.y)) {
					level.setThingPos(this, x + move.x, y + move.y);
					return;
				}
				else {
					movesCopy.splice(rIndex, 1);
				}
			}
			trace("can't move :)")
		}
		
		public function render(context:BitmapData):void {
			if (active) {
				renderMoves(context);
			}
			renderSelf(context);
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

		public function renderSelf(context:BitmapData):void {
			//renderSquare(context, x, y, 0x990099, 1);
			context.copyPixels(Player.image, new Rectangle(0, 20, 20, 20), new Point(x * Level.GRID_SIZE, y * Level.GRID_SIZE), null, null, true);
		}

		public function renderMoves(context:BitmapData):void {
			for each (var move:* in moves) {
				renderSquare(context, x + move.x, y + move.y, 0xFF00FF, 3)
			}
		}

	}
	
}
