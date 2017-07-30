package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	public class TextBox {

		[Embed(source="nokiafc22.ttf",
        fontName = "nokia",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const NOKIAFC22:Class;

		[Embed(source="m5x7.ttf",
        fontName = "m5x7",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const M5X7:Class;

		[Embed(source="m3x6.ttf",
        fontName = "m3x6",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const M3X6:Class;

		public var x:int;
		public var y:int;

		public var textField:TextField;
		public var textFormat:TextFormat;
		public var bgShape:Shape;
		public var bgColor:int;
		public var bgAlpha:Number;
		
		// "left", "right", "center"
		public function TextBox(fontName:String, color:int = 0, size:int = 8, align:String = "left"):void {
			textFormat = new TextFormat(fontName, size, color);
			textFormat.align = align;
			
			textField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.wordWrap = true;
			textField.autoSize = align;
			textField.embedFonts = true;
			textField.width = Main.WIDTH;
		}

		public function setBg(color:int, alpha:Number):void {
			this.bgColor = color;
			this.bgAlpha = alpha;
			bgShape = new Shape();
			redrawBg();
		}

		public function redrawBg():void {
			bgShape.graphics.clear();
			bgShape.graphics.beginFill(bgColor, bgAlpha);
			bgShape.graphics.drawRect(0, 0, textField.width, textField.height);
		}

		public function clearBg():void {
			bgShape.graphics.clear();
		}

		public function render(context:BitmapData):void {
			var matrix:Matrix = new Matrix();
			matrix.tx = x;
			matrix.ty = y;
			
			if (bgShape) {
				context.draw(bgShape, matrix);
			}
			
			context.draw(textField, matrix);
		}
		
	}
	
}