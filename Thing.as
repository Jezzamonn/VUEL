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
		
		public function get centerX():int {
			return (x + 0.5) * Level.GRID_SIZE;
		}
		public function get centerY():int {
			return (y + 0.5) * Level.GRID_SIZE;
		}

		// x y pairs
		public var moves:Array;

		public var power:int = 3;

		public var active:Boolean = false;
		public var disabled:Boolean = false;
		public var showMoves:Boolean = false;

		public var renderOffset:int = 1;

		public function Thing(level:Level) {
			this.level = level;

			moves = [
				{x: 0, y: 0},
			];
		}

		public function move():void {
			var movesCopy:Array = moves.slice();
			while (movesCopy.length > 0) {
				var rIndex:int = Rndm.integer(movesCopy.length);

				var move:Object = movesCopy[rIndex];
				if (level.validSquare(x + move.x, y + move.y)) {
					moveTo(x + move.x, y + move.y);
					return;
				}
				else {
					movesCopy.splice(rIndex, 1);
				}
			}
			trace("can't move :)")
		}
		
		public function moveTo(x:int, y:int):void {
			level.setThingAt(null, this.x, this.y, false);
			level.setThingAt(this, x, y);
		}
		
		public function canMoveTo(x:int, y:int):Boolean {
			if (!level.validSquare(x, y)) {
				return false;
			}
			for each (var move:* in moves) {
				if (this.x + move.x == x && this.y + move.y == y) {
					return true;
				}
			}
			return false;
		}
		
		public function render(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			renderSelf(context, xOffset, yOffset);
		}

		public function renderSquare(context:BitmapData, x:int, y:int, color:int, edge:int = 0, xOffset:int = 0, yOffset:int = 0):void {
			context.fillRect(
				new Rectangle(
					x * Level.GRID_SIZE + edge - xOffset,
					y * Level.GRID_SIZE + edge - yOffset,
					Level.GRID_SIZE - 2 * edge,
					Level.GRID_SIZE - 2 * edge
				),
				color
			);
		}

		public function renderSelf(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			//renderSquare(context, x, y, 0x990099, 1);
			context.copyPixels(
				Player.image,
				new Rectangle(20 * renderOffset, 0, 20, 20),
				new Point(
					x * Level.GRID_SIZE - xOffset,
					y * Level.GRID_SIZE - yOffset),
				null, null, true);
		}
		
		public function maybeRenderMoves(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			if (active || showMoves) {
				renderMoves(context, xOffset, yOffset);
			}
		}

		public function renderMoves(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			var rect:Rectangle = new Rectangle(20, 0, 20, 20);
			var point:Point = new Point();
			for each (var move:* in moves) {
				if (level.validSquare(x + move.x, y + move.y)) {
					point.x = (x + move.x) * Level.GRID_SIZE - xOffset;
					point.y = (y + move.y) * Level.GRID_SIZE - yOffset;
					context.copyPixels(Level.misc, rect, point, null, null, true);
				}
			}
		}

	}
	
}
