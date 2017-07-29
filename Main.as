package  {
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	
	public class Main extends MovieClip {

		public static const WIDTH:int = 600;
		public static const HEIGHT:int = 600;

		public var bitmap:Bitmap;
		public var bitmapData:BitmapData;
		
		
		public function Main() {
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0xFFFFFF);
			bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);

		}
	}
	
}
