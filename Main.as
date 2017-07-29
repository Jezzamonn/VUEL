﻿package  {
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	public class Main extends MovieClip {

		public static const WIDTH:int = 200;
		public static const HEIGHT:int = 200;

		public var bitmap:Bitmap;
		public var bitmapData:BitmapData;
		public var scale:Number;
		
		public var level:Level;
		
		public function Main() {
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0);
			bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);
			
			level = new Level();
			
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);
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
		
		public function onClick(evt:MouseEvent):void {
			var mousePoint:Point = new Point(evt.stageX, evt.stageY);
			mousePoint = bitmap.globalToLocal(mousePoint);
			
			level.onMouseDown(mousePoint.x, mousePoint.y);
		}
	}
	
}
