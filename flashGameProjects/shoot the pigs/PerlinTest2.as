package  {
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
	
	public class PerlinTest2 extends MovieClip{
		
		private const zeroPoint:Point = new Point(0,0);
		private var zeroArray:Array = [];
		private var circle:MovieClip = new MovieClip();
		private var greyData1:BitmapData = new BitmapData(400,400,false);
		private var greyData2:BitmapData = new BitmapData(400,400,false);
		private var greyData3:BitmapData = new BitmapData(400,400,false,0x0);
		private var coolingData:BitmapData = new BitmapData(400,400,false,0x0);
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
		private var finalData:BitmapData = new BitmapData(400,400,false);
		private var offsetArray:Array = [];
		private var colorSource:Sprite = new Sprite();
		private var colors:Array = [];
		private var fireColor:BitmapData = new BitmapData(256, 5, false, 0);
		private var gradMatrix:Matrix = new Matrix();
		private var convolution:ConvolutionFilter = new ConvolutionFilter(3, 3, [2, 1, 7,  1, 1, 1,  -1, 1, -4], 7);
		
		public function PerlinTest2() {
			startListeners();
			initPerlin();
			setColors();
			drawCircle();
			init();
		}
		
		private function startListeners():void {
			this.addEventListener(Event.ENTER_FRAME, eframe);
		}
		
		private function drawCircle():void {
			circle.graphics.beginBitmapFill(finalData,null,false,false);
			circle.graphics.drawCircle(200,200,200);
			circle.graphics.endFill();
			
		}
		
		private function initPerlin ():void {
			greyData1.perlinNoise(200,200,4,Math.random()*512,true,false,0,true,offsetArray);
			mapContainer1.addChild(greyMap1);
			greyData2.perlinNoise(200,200,4,Math.random()*512,true,false,0,true,offsetArray);
			greyMap1.blendMode = BlendMode.HARDLIGHT;
			greyMap2.blendMode = BlendMode.DIFFERENCE;
			//mapContainer2.blendMode = BlendMode.ADD;
			//mapContainer1.blendMode = BlendMode.ADD;
			greyMap2.x = -200;
			greyMap2.y = -200;
			mapContainer2.y = 200;
			mapContainer2.x = 200;
			mapContainer2.addChild(greyMap2);
			mapContainer1.addChild(mapContainer2);
			finalData.draw(mapContainer1);
		}
		
		private function setColors():void {
			gradMatrix.createGradientBox(256,5,0,0,0);
			colorSource.graphics.beginGradientFill(GradientType.RADIAL,[0x0,0xff6600,0xFFCC32,0xff0000],[1,1,1,1],[0, 128, 220, 255],gradMatrix,SpreadMethod.PAD);
			colorSource.graphics.drawRect(0, 0, 256, 20);
			fireColor.draw(colorSource);
			for (var i:int = 0; i < 256; i++) 
			{
				colors.push(this.fireColor.getPixel(i, 1));//Pick the colour values
				zeroArray.push(0);
			}
		}
		
		private function init():void {
			this.addChild(circle);
		}
		
		private function eframe (e:Event):void {
			mapContainer2.rotation += 1;
			finalData.draw(mapContainer1);
			finalData.applyFilter(finalData,finalData.rect,zeroPoint,convolution);
			//effect1,black ball with red veins
			//finalData.paletteMap(finalData,finalData.rect,zeroPoint,[0x0, 0xff6600, 0xFFCC32, 0xFF0000],[0],[0],[0]);
			
			//effect2
			//finalData.paletteMap(finalData,finalData.rect,zeroPoint,[0xff6600, 0xFFCC32, 0xFF0000]);
			
			//effect3
			greyData3.draw(finalData);
			greyData3.applyFilter(greyData3,greyData3.rect,zeroPoint,convolution);
			finalData.paletteMap(greyData3,greyData3.rect,zeroPoint,colors,zeroArray,zeroArray,zeroArray);
	
		}

	}
	
}
