package  {
	import flash.display.BitmapData;
	
	public class BuyPage {

		public var level:Level;
		
		public var choices:Array;

		public var textBox:TextBox;
		public var pointsDisplay:TextBox;
		
		public var greetingTextTimer:int = 24;

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

			setText("Interested in purchasing a new robot?")
		}

		public function setText(value:String):void {
			textBox.textField.text = value;
			textBox.y = Main.HEIGHT - textBox.textField.height;
		}
		
		public function update():void {
			greetingTextTimer --;
			for each (var choice:* in choices) {
				choice.update();
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
			
			level.player.moves = selectedThing.moves;
			level.state = Level.STATE_MOVE;
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
			
			if (greetingTextTimer <= 0) {
				if (hoverThing) {
					setText("$" + hoverThing.cost + "\n" + hoverThing.description);
				}
				else {
					setText("");
				}
			}
		}


	}
	
}
