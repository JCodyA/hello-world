package  {
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	
	public class GameOverBackDrop extends MovieClip{
		private var glow:GlowFilter;

		public function GameOverBackDrop() {
			this.x = 400;
			this.y = 200;
			this.alpha = .25;
			glow = new GlowFilter();
			glow.color = 0x00ff00;
			glow.blurX = 40;
			glow.blurY = 40;
			glow.alpha = 1;
			this.filters = [glow];
		}

	}
	
}
