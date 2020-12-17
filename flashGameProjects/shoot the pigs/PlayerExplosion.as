package  {
	/*Copyright 2012 Cody Arnholt, all rights reserved*/
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.filters.ConvolutionFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Stage;
	
	public class PlayerExplosion extends MovieClip{
		private var mute:Boolean = false;
		private var isPaused:Boolean = false;
		private var xScaler:int = 5;
		private var yScaler:int = 5;
		private var reducing:Boolean = false;
		private const zeroPoint:Point = new Point(0,0);
		private var zeroArray:Array = [];
		private var circle:MovieClip = new MovieClip();
		private var greyData1:BitmapData = new BitmapData(100,100,false);
		private var greyData2:BitmapData = new BitmapData(100,100,false);
		private var greyData3:BitmapData = new BitmapData(100,100,false,0x0);
		private var coolingData:BitmapData = new BitmapData(100,100,false,0x0);
		private var coolingFilter:ColorMatrixFilter = new ColorMatrixFilter([
				.8, 0, 0, 0, 0,
				0, .8, 0, 0, 0,
				0, 0, .8, 0, 0,
				0, 0, 0, .8, 0
			]);
		private var greyMap1:Bitmap = new Bitmap(greyData1);
		private var greyMap2:Bitmap = new Bitmap(greyData2);
		private var mapContainer1:Sprite = new Sprite();
		private var mapContainer2:Sprite = new Sprite();
		private var finalData:BitmapData = new BitmapData(100,100,false);
		private var offsetArray:Array = [];
		private var colorSource:Sprite = new Sprite();
		private const colors:Array = [];
		private var fireColor:BitmapData = new BitmapData(256, 5, false, 0);
		private var gradMatrix:Matrix = new Matrix();
		private var convolution:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1,  1, 1, 1,  -1, 1, -1], 5);
		//private var fadeTimer:Timer = new Timer(25);
		
		public function PlayerExplosion(stageRef:Stage) {
			this.addEventListener(Event.ENTER_FRAME, eframe);
			stageRef.addEventListener(ControlEvent.onPause,onPause,false,0,true);
			stageRef.addEventListener(ControlEvent.toggleMute,toggleMute,false,0,true);
			stageRef.addEventListener(ControlEvent.invisExplosions,invisExplosion,false,0,true);
			greyData1.perlinNoise(25,25,5,Math.random()*512,true,false,0,true,offsetArray);
			mapContainer1.addChild(greyMap1);
			greyData2.perlinNoise(25,25,5,Math.random()*512,true,false,0,true,offsetArray);
			//greyMap1.blendMode = BlendMode.HARDLIGHT;
			greyMap2.blendMode = BlendMode.DIFFERENCE;
			//mapContainer2.blendMode = BlendMode.ADD;
			//mapContainer1.blendMode = BlendMode.ADD;
			greyMap2.x = -50;
			greyMap2.y = -50;
			mapContainer2.y = 50;
			mapContainer2.x = 50;
			gradMatrix.createGradientBox(256,5,0,0,0);
			colorSource.graphics.beginGradientFill(GradientType.RADIAL,[0x0,0xff6600,0xFFCC32,0xff0000],[1,1,1,1],[0, 128, 220, 255],gradMatrix,SpreadMethod.PAD);
			colorSource.graphics.drawRect(0, 0, 256, 20);
			fireColor.draw(colorSource);
			for (var i:int = 0; i < 256; i++) 
			{
				colors.push(this.fireColor.getPixel(i, 1));//Pick the colour values
				zeroArray.push(0);
			}
			circle.graphics.beginBitmapFill(finalData,null,false,false);
			circle.graphics.drawCircle(50,50,50);
			circle.graphics.endFill();
			mapContainer2.addChild(greyMap2);
			mapContainer1.addChild(mapContainer2);
			finalData.draw(mapContainer1);
			finalData.applyFilter(finalData,finalData.rect,zeroPoint,convolution);
			greyData3.draw(finalData);
			greyData3.applyFilter(greyData3,greyData3.rect,zeroPoint,convolution);
			finalData.paletteMap(greyData3,greyData3.rect,zeroPoint,colors,zeroArray,zeroArray,zeroArray);
			circle.x -= 50;
			circle.y -= 50;
			this.addChild(circle);
			this.height = 5;
			this.width = 5;
		}
		
		private function eframe (e:Event):void {
			if (this.isPaused == false) {
				mapContainer2.rotation += 2;
				finalData.draw(mapContainer1);
				finalData.applyFilter(finalData,finalData.rect,zeroPoint,convolution);
				greyData3.draw(finalData);
				greyData3.applyFilter(greyData3,greyData3.rect,zeroPoint,convolution);
				finalData.paletteMap(finalData,finalData.rect,zeroPoint,[0xff6600, 0xFFCC32, 0xFF0000]);
				explode();
			}
		}
		private function removeMe():void {
			if (this.parent != null) {
				this.removeEventListener(Event.ENTER_FRAME,eframe);
				//fadeTimer.removeEventListener(TimerEvent.TIMER,fade);
				this.parent.removeChild(this);
			}
		}
		private function explode():void {
			if (this.width >= 400 && xScaler > 0) {
				xScaler = -7;
				yScaler = -7;
			}
			this.width += xScaler;
			this.height += yScaler;
			if (this.width <= 7) {
				removeMe();
			}
		}
		
		private function onPause(e:ControlEvent):void {
			switch (this.isPaused) {
				case true:
					this.isPaused = false;
					break;
				case false:
					this.isPaused = true;
					break;
			}
		}
		
		private function toggleMute(e:ControlEvent):void {
			if (this.mute == false) {
				this.mute = true;
			} else {
				this.mute = false;
			}
		}
		
		private function invisExplosion(e:ControlEvent):void {
			this.visible = false;
		}
		
		/*private function fade(e:TimerEvent):void {
			if (this.alpha > 0) {
				this.alpha -= .03;
			} else if (this.alpha <= 0) {
				removeMe();
			}
		}*/

	}
	
}