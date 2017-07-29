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
		
		public static const WIDTH:int = 10;
		public static const HEIGHT:int = 10;
		
		public var map:Array;
		public var thingMap:Array;

		public var player:Player;

		public var things:Array;

		private var _activeIndex:int = 0;

		public function get activeIndex():int {
			return _activeIndex;
		}

		public function set activeIndex(value:int):void {
			activeThing.active = false;
			_activeIndex = value % things.length;
			if (_activeIndex < 0) _activeIndex += things.length;
			activeThing.active = true;
		}

		public function get activeThing():Thing {
			return things[activeIndex];
		};

		public function set activeThing(value:Thing):void {
			// better not be -1 you jerk
			activeIndex = things.indexOf(value);
		}

		public var mouseOverred:Thing = null;

		public var count:int = 0;
		public var state:int = STATE_MOVE;

		public static const STATE_IDLE:int = 0;
		public static const STATE_MOVE:int = 1;
		public static const STATE_ANIM:int = 2;

		public function Level() {
			// constructor code
			map = [];
			thingMap = [];
			things = [];

			for (var y:int = 0; y < HEIGHT; y ++) {
				map[y] = [];
				thingMap[y] = [];
				for (var x:int = 0; x < WIDTH; x ++) {
					map[y][x] = 0;
					thingMap[y][x] = null;

					if (Rndm.boolean(0.7)) {
						map[y][x] = 1;
						if (Rndm.boolean(0.1)) {
							addThing(Enemy.randomEnemy(this), x, y);
						}
					}
				}
			}
			
			player = new Player(this); 
			var playerX:int = 0;
			var playerY:int = 0;
			do {
				playerX = Rndm.integer(WIDTH);
				playerY = Rndm.integer(HEIGHT);
			}
			while (!validSquare(playerX, playerY));
			addThing(player, playerX, playerY);
			activeThing = player;
		}

		public function getTileAt(x:int, y:int):int {
			if (x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT) {
				return 0;
			}
			return map[y][x];
		}

		public function getThingAt(x:int, y:int):Thing {
			if (x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT) {
				return null;
			}
			return thingMap[y][x];
		}

		
		public function validSquare(x:int, y:int):Boolean {
			if (x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT) {
				return false;
			}
			return !!map[y][x];
		}

		// really just has anything but player
		public function hasEnemy(x:int, y:int, ignore:Array = null):Boolean {
			if (x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT) {
				return false;
			}
			if (ignore == null) ignore = [];

			for each (var thing:* in ignore) {
				if (thingMap[y][x] == thing) {
					return false;
				}
			}
			return !!thingMap[y][x];
		}

		public function addThing(thing:Thing, x:int, y:int):void {
			thing.x = x;
			thing.y = y;
			if (thingMap[y][x]) {
				removeThing(thingMap[y][x]);
			}
			thingMap[y][x] = thing;
			things.push(thing);
		}

		public function removeThing(thing:Thing):void {
			var index:int = things.indexOf(thing);
			if (things[index] === player) {
			}
			if (activeIndex == index) {
				activeIndex --;
			}
			things.splice(index, 1);
			if (activeIndex > index) {
				_activeIndex --;
			}
		}

		public function setThingPos(thing:Thing, x:int, y:int):void {
			if (thingMap[y][x] && thingMap[y][x] !== thing) {
				removeThing(thingMap[y][x]);
			}
			thingMap[thing.y][thing.x] = null;
			thing.x = x;
			thing.y = y;
			thingMap[y][x] = thing;
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
						// pick the player move
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
		}

		public function onMouseDown(x:Number, y:Number):void {
			var gridX:int = Math.floor(x / GRID_SIZE);
			var gridY:int = Math.floor(y / GRID_SIZE);
			
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

			var gridX:int = Math.floor(x / GRID_SIZE);
			var gridY:int = Math.floor(y / GRID_SIZE);

			var thing:Thing = getThingAt(gridX, gridY);
			if (thing) {
				mouseOverred = thing;
				mouseOverred.showMoves = true;
			}
		}

		public function renderThings(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			for each (var thing:* in things) {
				thing.render(context);
			}
			//for (var y:int = 0; y < HEIGHT; y ++) {
			//	for (var x:int = 0; x < WIDTH; x ++) {
			//		if (things[y][x]) {
			//			things[y][x].render(context);
			//		}
			//	}
			//}
		}

		public function render(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			renderBg(context, xOffset, yOffset);
			renderThings(context, xOffset, yOffset);
		}
		
		public function renderBg(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			var rect:Rectangle = new Rectangle(0, 0, 20, 23);
			var point:Point = new Point();
			for (var y:int = 0; y < HEIGHT; y ++) {
				point.y = y * GRID_SIZE - 1;
				for (var x:int = 0; x < WIDTH; x ++) {
					point.x = x * GRID_SIZE;

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
