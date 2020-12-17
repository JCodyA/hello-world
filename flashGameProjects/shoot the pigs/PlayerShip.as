package  {
	/*Copyright 2012 Cody Arnholt, all rights reserved*/
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class PlayerShip extends MovieClip{
		//var declaration
		private var health:int;
		private var streamer:Streamer = new Streamer();
		
		public function PlayerShip() {
			streamer.x = this.x - 41;
			streamer.y = this.y;
			this.addChild(streamer);
		}

	}
	
}
