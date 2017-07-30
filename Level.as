package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.gskinner.utils.Rndm;
	
	public class Level {

		[Embed(source = "graphics/tiles.png")]
		private static const TILES_CLASS:Class;
		private static var _tiles:BitmapData;
		public static function get tiles():BitmapData {
			if (!_tiles) {
				_tiles = (new TILES_CLASS()).bitmapData;
			}
			return _tiles;
		}
		[Embed(source = "graphics/misc.png")]
		private static const MISC_CLASS:Class;
		private static var _misc:BitmapData;
		public static function get misc():BitmapData {
			if (!_misc) {
				_misc = (new MISC_CLASS()).bitmapData;
			}
			return _misc;
		}

		public static const GRID_SIZE:int = 20;
		
		public static const WIDTH:int = 9;
		public static const HEIGHT:int = 9;

		public var camX:Number = WIDTH * GRID_SIZE / 2;
		public var camY:Number = HEIGHT * GRID_SIZE  / 2;
		public var desiredCamX:Number = 0;
		public var desiredCamY:Number = 0;
		public function get xOffset():int {
			return Math.floor(camX - Main.WIDTH / 2);
		}
		public function get yOffset():int {
			return Math.floor(camY - Main.WIDTH / 2);
		}
		
		public var player:Player;

		// 2D array of pieces
		public var pieces:Array;
		public var piecesLeft:int = 0;
		public var piecesTop:int = 0;
		public var piecesWidth:int = 1;
		public var piecesHeight:int = 1;
		public var things:Array;

		private var _activeIndex:int = 0;

		public function get activeIndex():int {
			return _activeIndex;
		}

		public function set activeIndex(value:int):void {
			if (activeThing) {
				activeThing.active = false;
			}
			_activeIndex = value % things.length;
			if (_activeIndex < 0) _activeIndex += things.length;
			activeThing.active = true;
		}

		public function get activeThing():Thing {
			if (activeIndex > things.length) {
				return null;
			}
			return things[activeIndex];
		};

		public function set activeThing(value:Thing):void {
			// better not be -1 you jerk
			activeIndex = things.indexOf(value);
		}

		public var mouseOverred:Thing = null;

		public var batteryIcon:BatteryIcon;
		
		public var count:int = 0;
		public var state:int = STATE_MOVE;

		public static const STATE_IDLE:int = 0;
		public static const STATE_MOVE:int = 1;
		public static const STATE_ANIM:int = 2;

		public function Level() {
			batteryIcon = new BatteryIcon();
			regen();
		}

		public function regen():void {
			pieces = [[null]];
			addLevelPiece(0, 0);

			things = [];

			player = new Player(this); 
			var playerX:int = 0;
			var playerY:int = 0;
			do {
				playerX = Rndm.integer(WIDTH);
				playerY = Rndm.integer(HEIGHT);
			}
			while (!validSquare(playerX, playerY));
			setThingAt(player, playerX, playerY);
			activeThing = player;
			
			batteryIcon.player = player;
		}

		public function addLevelPiece(x:int, y:int):void {
			var row:*;
			var newRow:Array;
			var i:int;

			while (x < piecesLeft) {
				// Add left column
				for each (row in pieces) {
					row.unshift(null);
				}
				piecesLeft --;
			}
			while (x >= piecesLeft + piecesWidth) {
				// Add right column
				for each (row in pieces) {
					row.push(null);
				}
				piecesWidth ++;
			}

			while (y < piecesTop) {
				// Add top row
				newRow = [];
				for (i = 0; i < piecesWidth; i ++) {
					newRow.push(null);
				}
				pieces.unshift(newRow);
				piecesTop --;
			}
			while (y >= piecesTop + piecesHeight) {
				// Add bottom row
				newRow = [];
				for (i = 0; i < piecesWidth; i ++) {
					newRow.push(null);
				}
				pieces.push(newRow);
				piecesHeight ++;
			}

			// TODO: Set this properly?
			pieces[y + piecesTop][x + piecesLeft] = new LevelPiece(this, x, y);
		}

		public function getPieceAtPieceCoord(x:int, y:int):LevelPiece {
			if (x < piecesLeft || y < piecesTop || x >= piecesLeft + piecesWidth || y >= piecesTop + piecesHeight) {
				return null;
			}
			return pieces[y + piecesTop][x + piecesLeft];
		}

		public function getPieceAtGridCoord(x:int, y:int):LevelPiece {
			var pieceX:int = Math.floor(x / LevelPiece.WIDTH);
			var pieceY:int = Math.floor(y / LevelPiece.HEIGHT);

			return getPieceAtPieceCoord(pieceX, pieceY);
		}

		public function getTileAt(x:int, y:int):int {
			var piece:LevelPiece = getPieceAtGridCoord(x, y);
			if (piece == null) {
				return 0;
			}

			var relX:int = Util.absMod(x, LevelPiece.WIDTH);
			var relY:int = Util.absMod(y, LevelPiece.HEIGHT);

			return piece.map[relY][relX];
		}

		public function getThingAt(x:int, y:int):Thing {
			var piece:LevelPiece = getPieceAtGridCoord(x, y);
			if (piece == null) {
				return null;
			}

			var relX:int = Util.absMod(x, LevelPiece.WIDTH);
			var relY:int = Util.absMod(y, LevelPiece.HEIGHT);

			return piece.thingMap[relY][relX];
		}

		public function setThingAt(thing:Thing, x:int, y:int):void {
			var piece:LevelPiece = getPieceAtGridCoord(x, y);
			if (piece == null) {
				return;
			}

			thing.x = x;
			thing.y = y;
			var relX:int = Util.absMod(x, LevelPiece.WIDTH);
			var relY:int = Util.absMod(y, LevelPiece.HEIGHT);
			piece.thingMap[relY][relX] = thing;
		}

		
		public function validSquare(x:int, y:int):Boolean {
			return !!getTileAt(x, y);
		}

		// really just has anything but player
		public function hasEnemy(x:int, y:int, ignore:Array = null):Boolean {
			if (ignore == null) ignore = [];

			var thing:Thing = getThingAt(x, y);
			for each (var ignoreThing:* in ignore) {
				if (thing == ignoreThing) {
					return false;
				}
			}
			return !!thing;
		}

		public function update():void {
			count ++;
			switch (state) {
				case STATE_IDLE:
					// nothing?
					break;
				case STATE_MOVE:
					// pick ya move
					if (activeThing == player) {
						// wait for the player to pick a move
					}
					else {
						//if (count > 4) {
							activeThing.move();
							activeIndex ++;
							count = 0;
						//}
					}
					break;
				case STATE_ANIM:
					// wait for anim?
					break;
			}

			//desiredCamX = player.centerX;
			//desiredCamY = player.centerY;
			
			// update cam
			//camX += (desiredCamX - camX) / 10;
			//camY += (desiredCamY - camY) / 10;
		}

		public function onMouseDown(x:Number, y:Number):void {
			var localX:int = x + xOffset;
			var localY:int = y + yOffset;

			var gridX:int = Math.floor(localX / GRID_SIZE);
			var gridY:int = Math.floor(localY / GRID_SIZE);
			
			if (state == STATE_MOVE && activeThing == player && player.canMoveTo(gridX, gridY)) {
				player.moveTo(gridX, gridY);
				activeIndex ++;
			}
		}

		public function onMouseMove(x:Number, y:Number):void {
			if (mouseOverred) {
				mouseOverred.showMoves = false;
			}
			mouseOverred = null;
			
			var localX:int = x + xOffset;
			var localY:int = y + yOffset;

			var gridX:int = Math.floor(localX / GRID_SIZE);
			var gridY:int = Math.floor(localY / GRID_SIZE);

			var thing:Thing = getThingAt(gridX, gridY);
			if (thing) {
				mouseOverred = thing;
				mouseOverred.showMoves = true;
			}
		}

		public function render(context:BitmapData):void {
			context.fillRect(context.rect, 0x151729);
			renderBg(context, xOffset, yOffset);
			renderThings(context, xOffset, yOffset);
			renderMoves(context, xOffset, yOffset);
			
			batteryIcon.render(context);
		}
		
		public function renderThings(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			for each (var thing:* in things) {
				thing.render(context, xOffset, yOffset);
			}
		}
		
		public function renderMoves(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			for each (var thing:* in things) {
				thing.maybeRenderMoves(context, xOffset, yOffset);
			}
		}
		
		public function renderBg(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			var rect:Rectangle = new Rectangle(0, 0, 20, 23);
			var point:Point = new Point();
			for (var y:int = 0; y < HEIGHT; y ++) {
				point.y = y * GRID_SIZE - yOffset;
				for (var x:int = 0; x < WIDTH; x ++) {
					point.x = x * GRID_SIZE - xOffset;

					if (getTileAt(x, y)) {
						if (getTileAt(x, y+1)) {
							rect.x = 0 * rect.width;
							rect.y = 0 * rect.height;
						}
						else {
							rect.x = 1 * rect.width;
							rect.y = 0 * rect.height;
						}
						context.copyPixels(tiles, rect, point, null, null, true);
					}
				}
			}
		}


	}
	
}
