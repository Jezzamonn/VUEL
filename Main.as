package  {
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	
	public class Main extends MovieClip {

		public static const WIDTH:int = 600;
		public static const HEIGHT:int = 600;

		public var bitmap:Bitmap;
		public var bitmapData:BitmapData;
		
		public var level:Level;
		
		
		public function Main() {
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0xFFFFFF);
			bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);
			
			level = new Level();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(evt:Event) {
			level.render(bitmapData);
		}
	}
	
}
