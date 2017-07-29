package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import com.gskinner.utils.Rndm;
	
	public class Level {

		public static const GRID_SIZE:int = 20;
		
		public static const WIDTH:int = 10;
		public static const HEIGHT:int = 10;
		
		public var map:Array;
		public var things:Array;

		public var player:Player;
		public var activeThings:Array;
		private var _thingIndex:int = 0;
		public function get thingIndex():int {
			return _thingIndex;
		}
		public function set thingIndex(value:int):void {
			activeThing.active = false;
			_thingIndex = value % activeThings.length;
			if (_thingIndex < 0) {
				_thingIndex += activeThings.length;
			}
			activeThing.active = true;
		}
		public function get activeThing():Thing { return activeThings[thingIndex] };

		public var count:int = 0;
		public var state:int = 0;

		public static const STATE_IDLE:int = 0;
		public static const STATE_PICK_MOVE:int = 1;

		public function Level() {
			// constructor code
			map = [];
			things = [];
			activeThings = [];

			for (var y:int = 0; y < HEIGHT; y ++) {
				map[y] = [];
				things[y] = [];
				for (var x:int = 0; x < WIDTH; x ++) {
					map[y][x] = 0;
					things[y][x] = null;

					if (Math.random() < 0.7) {
						map[y][x] = 1;
					}

					if (Math.random() < 0.2) {
						addThing(new Thing(this), x, y);
					}
				}
			}
			
			addThing(new Player(this), Rndm.integer(WIDTH), Rndm.integer(HEIGHT));
		}

		public function addThing(thing:Thing, x:int, y:int):void {
			thing.x = x;
			thing.y = y;
			things[y][x] = thing;
			activeThings.push(thing);
		}

		public function update():void {
			count ++;
			if (count > 4) {
				thingIndex ++;
				count = 0;
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

		public function renderThings(context:BitmapData, xOffset:int = 0, yOffset:int = 0):void {
			for (var y:int = 0; y < HEIGHT; y ++) {
				for (var x:int = 0; x < WIDTH; x ++) {
					if (things[y][x]) {
						things[y][x].render(context);
					}
				}
			}
		}

	}
	
}
