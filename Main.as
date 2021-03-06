﻿package  {
	
	import com.gskinner.utils.Rndm;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import flash.display.StageAlign;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	
	public class Main extends MovieClip {

		public static const WIDTH:int = 200;
		public static const HEIGHT:int = 200;
		public static const SECONDS:int = 24;

		public var bitmap:Bitmap;
		public var bitmapData:BitmapData;
		public var scale:Number;

		public static var muted:Boolean = false;
		public static var screenShake:Boolean = true;
		
		public var level:Level;
		
		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
			
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0);
			bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);

			// init random seed to something actually random
			Rndm.seed = 0xFFFFFF * Math.random();
			
			level = new Level();
			
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

			SoundManager.init();
			SoundManager.startSong();
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
			onMouseMove();

			level.update();

			level.render(bitmapData);
		}
		
		public function onClick(evt:MouseEvent):void {
			var mousePoint:Point = new Point(evt.stageX, evt.stageY);
			mousePoint = bitmap.globalToLocal(mousePoint);
			
			level.onMouseDown(mousePoint.x, mousePoint.y);
		}

		public function onMouseMove(evt:Event = null):void {
			var mousePoint:Point = new Point(stage.mouseX, stage.mouseY);
			mousePoint = bitmap.globalToLocal(mousePoint);
			
			level.onMouseMove(mousePoint.x, mousePoint.y);
		}

		public function onKeyDown(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
				case Keyboard.R:
					level.regen();
					break;
				case Keyboard.M:
					muted = !muted;
					SoundMixer.soundTransform = new SoundTransform(muted ? 0 : 1);
					break;
				case Keyboard.S:
					screenShake = !screenShake;
					break;
			}
		}
	}
	
}
