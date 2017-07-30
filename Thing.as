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

		// hack for the buy page
		public var bought:Boolean = false;
		public var cost:int = 0;
		public function get costString():String {
			return bought ? "bought" : "$" + cost;
		}

		public var dead:Boolean = false;
		public var animating:Boolean = false;
		public var animAmt:Number = 1;
		public var prevX:int;
		public var prevY:int;
		public var replacingThing:Thing;
		
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
		public var frameCount:int = 0;

		public var name:String = "Thing";
		public var description:String = "This is just a thing. Carry on."

		public function Thing(level:Level) {
			this.level = level;

			moves = [
				{x: 0, y: 0},
			];

			frameCount = Rndm.integer(8 * 3);
		}

		public function startMoveAnim(move:Object = null):void {
			if (move == null) {
				move = pickMove();
			}
			// still null? give up chum 
			if (move == null) {
				return;
			}

			this.prevX = x;
			this.prevY = y;
			animating = true;
			animAmt = 0;
			moveTo(x + move.x, y + move.y);
		}

		public function pickMove():Object {
			var movesCopy:Array = moves.slice();
			while (movesCopy.length > 0) {
				var rIndex:int = Rndm.integer(movesCopy.length);

				var move:Object = movesCopy[rIndex];
				if (level.validSquare(x + move.x, y + move.y)) {
					return move;
				}
				else {
					movesCopy.splice(rIndex, 1);
				}
			}
			trace("can't move :')")
			return null;
		}

		public function doMove():void {
			makeMoveSound();
			// crush anything underneath
			if (replacingThing && replacingThing !== this) {
				level.removeThing(replacingThing);
			}
		}

		public function makeMoveSound():void {
			var thing:Thing = replacingThing;
			if (thing && thing !== this) {
				SoundManager.playSound("splode");
			}
			else {
				SoundManager.playSound("hop");
			}
		}
		
		public function moveTo(x:int, y:int):void {
			replacingThing = level.getThingAt(x, y);
			level.setThingAt(null, this.x, this.y, false);
			level.setThingAt(this, x, y, false);
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

		public function update():void {
			frameCount ++;
			if (animating) {
				animAmt += 0.2;
				if (animAmt >= 1) {
					// actually do the move here.
					doMove();
					animAmt = 1;
					animating = false;
				}
			}
		}

		public function get frame():int {
			return (frameCount / 3) % 3
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
				new Rectangle(20 * renderOffset, 20 * frame, 20, 20),
				new Point(
					getAnimX() - xOffset,
					getAnimY() - yOffset),
				null, null, true);
		}

		public function getAnimX():int {
			var xPos:Number = prevX * (1 - animAmt) + x * animAmt;
			return Math.round(xPos * Level.GRID_SIZE);
		}

		public function getAnimY():int {
			var baseY:Number = prevY * (1 - animAmt) + y * animAmt;
			var jumpAmt:Number = 4 * animAmt * (1 - animAmt);
			var jumpY:Number = -0.5 * jumpAmt;
			return Math.round((baseY + jumpY) * Level.GRID_SIZE);
		}
		
		public function maybeRenderMoves(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			if (showMoves) {
				renderMoves(context, xOffset, yOffset);
			}
		}

		public function renderMoves(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			var rect:Rectangle = new Rectangle(20, 0, 20, 20);
			var point:Point = new Point();
			for each (var move:* in moves) {
				if (!level || level.validSquare(x + move.x, y + move.y)) {
					point.x = (x + move.x) * Level.GRID_SIZE - xOffset;
					point.y = (y + move.y) * Level.GRID_SIZE - yOffset;
					context.copyPixels(Level.misc, rect, point, null, null, true);
				}
			}
		}

	}
	
}
