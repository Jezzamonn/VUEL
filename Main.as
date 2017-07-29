package  {
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	
	public class Main extends MovieClip {

		public static const WIDTH:int = 200;
		public static const HEIGHT:int = 200;

		public var bitmap:Bitmap;
		public var bitmapData:BitmapData;
		public var scale:Number;
		
		public var level:Level;
		
		public function Main() {
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0xFFFFFF);
			bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);
			
			level = new Level();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);

			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		public function onResize(evt:Event = null):void {
			var xScale:Number = stage.stageWidth / WIDTH;
			var yScale:Number = stage.stageHeight / HEIGHT;
			scale = Math.floor(Math.min(xScale, yScale));

			bitmap.scaleX = scale;
			bitmap.scaleY = scale;
			bitmap.x = (stage.stageWidth - scale * WIDTH) / 2;
			bitmap.y = (stage.stageHeight - scale * HEIGHT) / 2;
		}

		public function onEnterFrame(evt:Event):void {
			level.update();

			level.render(bitmapData);
		}
	}
	
}
