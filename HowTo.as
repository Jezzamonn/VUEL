package  {
	import flash.display.BitmapData;
	
	public class HowTo {

		public var textBox:TextBox;
		
		public function HowTo() {
			textBox = new TextBox("nokia", Level.COLORS[3], 8);
			textBox.textField.text = 
				"How to survive in the year 2196:\n\n" +
				"- Click a square to move\n\n" +
				"- Click yourself to wait\n\n" +
				"- Stomp things to take their power\n\n" +
				"- Don't run out of power\n\n" +
				"- Don't get stomped";
			textBox.y = 0.2 * Main.HEIGHT;
			textBox.x = 2;
		}
		
		public function render(context:BitmapData):void {
			context.fillRect(context.rect, Level.COLORS[1])
			textBox.render(context);
		}

	}
	
}
