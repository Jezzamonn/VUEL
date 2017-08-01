package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class BuyPage {

		[Embed(source = "graphics/shoppie.png")]
		private static const IMAGE_CLASS:Class;
		private static var _image:BitmapData;
		public static function get image():BitmapData {
			if (!_image) {
				_image = (new IMAGE_CLASS()).bitmapData;
			}
			return _image;
		}

		public var level:Level;
		
		public var choices:Array;

		public var textBox:TextBox;
		public var pointsDisplay:TextBox;
		
		public static const PAUSE_LENGTH:int = 4 * Main.SECONDS;
		public var textPauseTimer:int = PAUSE_LENGTH;

		public var beenHereBefore:Boolean = false;

		public var shoppieTalkCount:int = 0;
		public var shoppieEmotion:int = 0;

		public function BuyPage(level:Level) {
			this.level = level;
			
			textBox = new TextBox("m3x6", Level.COLORS[4], 16);
			textBox.textField.width = Main.WIDTH - 50;

			pointsDisplay = new TextBox("nokia", Level.COLORS[1], 16, "right");
			pointsDisplay.x = 0;
			pointsDisplay.y = 0;
			pointsDisplay.textField.text = "$0";

			choices = [];
			for (var i:int = 0; i < 8; i ++) {
				var thing:Player = new Player(null);
				//thing.showMoves = true;
				thing.active = false;
				thing.description = "Excellent Eyebrows";
				thing.renderOffset = i;
				choices.push(thing);
			}
			for (var i:int = 0; i < 4; i ++) {
				choices[i].y = 2 + i;
				choices[i].x = 2 + (i + 1) % 2;

				choices[i+4].y = 2 + i;
				choices[i+4].x = 6 + i % 2;
			}
			choices[0].bought = true;
			choices[0].description = "Pretty good eyebrows. 7/10";

			choices[1].moves = [
				{x: 0, y: 0},

				{x:  1, y:  0},
				{x: -1, y:  0},
				{x:  0, y:  1},
				{x:  0, y: -1},
				
				{x:  1, y:  1},
				{x: -1, y:  1},
				{x:  1, y: -1},
				{x: -1, y: -1},
			]
			choices[1].cost = 20;
			choices[1].description = "Small eyebrows, but they're pretty good. 6/10";
			choices[1].reaction = 1;

			choices[2].moves = [
				{x: 0, y: 0},

				{x:  1, y:  2},
				{x: -1, y:  2},
				{x:  1, y: -2},
				{x: -1, y: -2},
				
				{x:  2, y:  1},
				{x:  2, y: -1},
				{x: -2, y:  1},
				{x: -2, y: -1},
			];
			choices[2].cost = 60;
			choices[2].description = "No eyebrows? Disgusting. No rating.";
			choices[2].reaction = 3;

			choices[3].moves = [
				{x:  0, y:  0},
				{x:  0, y: -1},
				{x:  0, y: -2},

				{x:  1, y:  0},
				{x:  1, y:  1},
				{x:  1, y:  2},

				{x: -1, y:  0},
				{x: -1, y:  1},
				{x: -1, y:  2},
			];
			choices[3].cost = 50;
			choices[3].description = "These eyebrows embody the spirit of anger. 8/10";

			choices[4].moves = [
				{x:  0, y:  0},

				{x: -1, y:  0},
				{x:  1, y:  0},
				{x:  0, y: -1},
				{x:  0, y:  1},

				{x: -3, y:  0},
				{x:  3, y:  0},
				{x:  0, y: -3},
				{x:  0, y:  3},
			];
			choices[4].cost = 70;
			choices[4].description = "This robot conveys the feeling of worry using the power of its eyebrows. 8/10";

			choices[5].moves = [
				{x: 0, y: 0},

				{x:  2, y:  0},
				{x: -2, y:  0},
				{x:  0, y:  2},
				{x:  0, y: -2},
				
				{x:  2, y:  1},
				{x: -2, y:  1},
				{x:  1, y:  2},
				{x:  1, y: -2},
				
				{x:  2, y: -1},
				{x: -2, y: -1},
				{x: -1, y:  2},
				{x: -1, y: -2},
				
				{x:  2, y:  2},
				{x: -2, y:  2},
				{x:  2, y: -2},
				{x: -2, y: -2},
			];
			choices[5].cost = 120;
			choices[5].description = "Now those are some eyebrows I can get behind. 9/10";

			choices[6].moves = [
				{x: 0, y:  0},
				{x: 0, y: -1},

				{x:  1, y:  1},
				{x: -1, y:  1},
				{x:  1, y: -1},
				{x: -1, y: -1},

				{x:  2, y:  2},
				{x: -2, y:  2},
				{x:  2, y: -2},
				{x: -2, y: -2},
			];
			choices[6].cost = 70;
			choices[6].description = "Perpetually confused eyebrows. OK. 7/10";
			choices[6].reaction = 1;

			choices[7].moves = [
				{x: 0, y: 0},
			];
			choices[7].cost = 200;
			choices[7].description = "Optimal eyebrows. Cannot get better than this. 11/10";
			choices[7].reaction = 2;
				
			var temp:int = choices[4].y;
			choices[4].y = choices[6].y;
			choices[6].y = temp;

			// DEBUG:
			//for each (var choice:* in choices) {
			//	choice.cost /= 10;
			//}

		}

		public function start():void {
			// this is called before total points is updated.
			pointsDisplay.textField.text = "$" + level.points + " + $" + level.totalPoints;
			if (!beenHereBefore) {
				setText("Interested in purchasing a new robot?")
				textPauseTimer = PAUSE_LENGTH;
				beenHereBefore = true;
			}
		}

		public function setText(value:String):void {
			textBox.textField.text = value;
			textBox.y = Main.HEIGHT - textBox.textField.height;
		}
		
		public function update():void {
			textPauseTimer --;
			for each (var choice:* in choices) {
				choice.update();
			}
			if (textPauseTimer <= 0) {
				pointsDisplay.textField.text = "$" + level.totalPoints;
			}

			if (textBox.textField.text && textBox.textField.text.length > 0) {
				shoppieTalkCount ++;
			}
			else {
				shoppieTalkCount = 0;
			}
		}
		
		public function render(context:BitmapData):void {
			context.fillRect(context.rect, Level.COLORS[0])
			textBox.render(context);
			pointsDisplay.render(context);

			for each (var choice:* in choices) {
				choice.render(context);
			}
			for each (var choice:* in choices) {
				choice.maybeRenderMoves(context);
			}

			// SHOPPIE
			var rect:Rectangle = new Rectangle(0, 0, 50, 50);
			rect.x = shoppieEmotion * rect.width;
			rect.y = (Math.floor(shoppieTalkCount / 3) % 2) * rect.height;
			
			var point:Point = new Point();
			point.x = Main.WIDTH - rect.width;
			point.y = Main.HEIGHT - rect.height;
			
			context.copyPixels(image, rect, point, null, null, true);
		}
		
		public function onMouseDown(x:Number, y:Number):void {
			var localX:int = x;
			var localY:int = y;

			var gridX:int = Math.floor(localX / Level.GRID_SIZE);
			var gridY:int = Math.floor(localY / Level.GRID_SIZE);

			var selectedThing:Thing;
			for each (var choice:* in choices) {
				if (choice.x == gridX && choice.y == gridY) {
					selectedThing = choice;
					break;
				}
			}
			
			if (selectedThing) {
				// do the buy
				if (level.totalPoints >= selectedThing.cost) {
					level.totalPoints -= selectedThing.cost;
					selectedThing.bought = true;
					
					// START THE GAME

					level.player.moves = selectedThing.moves;
					level.player.renderOffset = selectedThing.renderOffset;
					level.state = Level.STATE_MOVE;
					level.regen();
					SoundManager.setSong("song");
				}
				else {
					setText("You don't have enough for that.")
					textPauseTimer = PAUSE_LENGTH;
				}
			}
		}

		public function onMouseMove(x:Number, y:Number):void {
			var localX:int = x;
			var localY:int = y;

			var gridX:int = Math.floor(localX / Level.GRID_SIZE);
			var gridY:int = Math.floor(localY / Level.GRID_SIZE);

			var hoverThing:Thing;
			for each (var choice:* in choices) {
				if (choice.x == gridX && choice.y == gridY) {
					choice.showMoves = true;
					hoverThing = choice;
				}
				else {
					choice.showMoves = false;
				}
			}
			
			if (textPauseTimer <= 0) {
				if (hoverThing) {
					setText(hoverThing.costString + "\n" + hoverThing.description);
					shoppieEmotion = hoverThing.reaction;
				}
				else {
					setText("");
				}
			}
		}


	}
	
}
