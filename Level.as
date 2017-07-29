package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import com.gskinner.utils.Rndm;
	
	public class Level {

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
					}

					if (Rndm.boolean(0.2)) {
						addThing(new Thing(this), x, y);
					}
				}
			}
			
			player = new Player(this); 
			addThing(player, Rndm.integer(WIDTH), Rndm.integer(HEIGHT));
		}

		public function validSquare(x:int, y:int):Boolean {
			if (x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT) {
				return false;
			}
			return !!map[y][x];
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
						if (count > 4) {
							activeThing.move();
							activeIndex ++;
							count = 0;
						}
					}
					break;
				case STATE_ANIM:
					// wait for anim?
					break;
			}
		}

		public function render(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			renderBg(context, xOffset, yOffset);
			renderThings(context, xOffset, yOffset);
		}
		
		public function renderBg(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			var rect:Rectangle = new Rectangle(0, 0, GRID_SIZE, GRID_SIZE);
			for (var y:int = 0; y < HEIGHT; y ++) {
				rect.y = y * GRID_SIZE;
				for (var x:int = 0; x < WIDTH; x ++) {
					rect.x = x * GRID_SIZE;
					var color:int = map[y][x] ? 0xFFFFFF : 0;
					context.fillRect(rect, color);
				}
			}
		}
		
		public function onMouseDown(x:Number, y:Number):void {
			var gridX:int = Math.floor(x / GRID_SIZE);
			var gridY:int = Math.floor(y / GRID_SIZE);
			
			if (state == STATE_MOVE && activeThing == player && player.canMoveTo(gridX, gridY)) {
				player.moveTo(gridX, gridY)
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

	}
	
}
