package  {
	import flash.display.BitmapData;
	
	public class BuyPage {

		public var level:Level;
		
		public var choices:Array;

		public var textBox:TextBox;
		public var pointsDisplay:TextBox;
		
		public static const PAUSE_LENGTH:int = 4 * Main.SECONDS;
		public var textPauseTimer:int = PAUSE_LENGTH;

		public function BuyPage(level:Level) {
			this.level = level;
			
			textBox = new TextBox("m3x6", Level.COLORS[4], 16);
			textBox.textField.width += 2;

			pointsDisplay = new TextBox("nokia", Level.COLORS[1], 16, "right");
			pointsDisplay.x = 0;
			pointsDisplay.y = 0;
			pointsDisplay.textField.text = "$0";

			choices = [];
			for (var i:int = 0; i < 4; i ++) {
				var thing:Player = new Player(null);
				thing.x = 3 + 3 * (i % 2);
				thing.y = 2 + 3 * (Math.floor(i / 2));
				//thing.showMoves = true;
				thing.active = false;
				thing.description = "Excellent Eyebrows"
				choices.push(thing);
			}
			choices[0].bought = true;
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
			choices[2].cost = 50;

			choices[3].moves = [
				{x: 0, y: 0},

				{x:  0, y:  -1},
				{x:  0, y:  -2},

				{x:  1, y:  0},
				{x:  1, y:  1},
				{x:  1, y:  2},

				{x: -1, y:  0},
				{x: -1, y:  1},
				{x: -1, y:  2},
			];
			choices[3].cost = 60;

			// DEBUG:
			for each (var choice:* in choices) {
				choice.cost /= 10;
			}

			setText("Interested in purchasing a new robot?")
		}

		public function start():void {
			// this is called before total points is updated.
			pointsDisplay.textField.text = "$" + level.points + " + $" + level.totalPoints;
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

					level.player.moves = selectedThing.moves;
					level.state = Level.STATE_MOVE;
					level.regen();
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
				}
				else {
					setText("");
				}
			}
		}


	}
	
}
