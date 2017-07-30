package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	
	public class TextBox {

		[Embed(source="nokiafc22.ttf",
        fontName = "nokia",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const NOKIAFC22:Class;

		public var x:int;
		public var y:int;

		public var textField:TextField;
		public var textFormat:TextFormat;
		
		// "left", "right", "center"
		public function TextBox(color:int = 0, size:int = 8, align:String = "left"):void {
			textFormat = new TextFormat("nokia", size, color);
			textFormat.align = align;
			
			textField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.wordWrap = true;
			textField.autoSize = align;
			textField.embedFonts = true;
		}

		public function render(context:BitmapData):void {
			var matrix:Matrix = new Matrix();
			matrix.tx = x;
			matrix.ty = y;
			
			context.draw(textField, matrix);
		}
		
	}
	
}