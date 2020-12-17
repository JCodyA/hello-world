package  {
	/*Copyright 2012 Cody Arnholt, all rights reserved*/
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	
	public class Fire extends MovieClip{
		private var glow:GlowFilter;
		private var glowSpeed:Number;

		public function Fire() {
			this.alpha = 1;
			glow = new GlowFilter();
			glow.color = 0xff0000;
			glow.blurX = 10;
			glow.blurY = 10;
			glow.alpha = 0;
			glowSpeed = .1;
			this.filters = [glow];
			this.addEventListener(Event.ENTER_FRAME, eframe);
			
		}
		private function eframe(e:Event):void {
			if (glow.alpha == 0 && glowSpeed < 0) {
				glowSpeed *= -1;
			} else if (glow.alpha == 1  && glowSpeed > 0) {
				glowSpeed *= -1;
			}
			glow.alpha += glowSpeed;
			this.filters = [glow];
		}

	}
	
}
