package  {
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.ColorTransform;
	import flash.filters.GlowFilter;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	public class Streamer extends MovieClip{
		private var firstParticle:Particle;
		private var lastParticle:Particle;
		private var pColor:uint = 0xff0000;
		private var bmpData:BitmapData = new BitmapData(50,50,true,0x00000000);
		private var bmp:Bitmap = new Bitmap(bmpData);
		private var colorForm:ColorTransform = new ColorTransform(1,1,1,1,1,0,0,-25);
		private var glowFilter:GlowFilter = new GlowFilter(0xff0000,.25,2,2,1);
		public function Streamer() {
			for (var i = 0; i<75;i++) {
				var p = new Particle();
				if (i == 0) {
					this.firstParticle = p;
				} else if (i < 74) {
					lastParticle.next = p;
				} else {
					lastParticle.next = firstParticle;
				}
				lastParticle = p;
			}
			bmp.x -= 25;
			bmp.y -= 25;
			this.addChild(bmp);
			this.addEventListener(Event.ENTER_FRAME,onEframe);
		}
		private function onEframe(e:Event):void {
			var p = firstParticle;
			bmpData.colorTransform(bmpData.rect,colorForm);
			bmpData.applyFilter(bmpData,bmpData.rect,new Point(0,0),glowFilter);
			bmpData.lock();
			do {
				p.x -= Math.random()*3;
				p.y += p.rise;
				//p.y *= Math.cos(p.x);
				bmpData.setPixel32(p.x,p.y,(p.alpha << 24) | this.pColor);
				
				p.alpha -= ((Math.random()*0xff)/16)+0x05;
				 if (p.alpha <= 0x00 || p.alpha > 255) {
					p.alpha = 0xff;
					p.x = 50;
					p.y = 25;
				}
				p = p.next;
			} while (p != firstParticle)
			bmpData.unlock();
		}

	}
	
}
