package  {
	
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import flash.events.Event;
	import flash.display.Stage;
	
	public class bringTheBigGun extends MovieClip {
		private var preLoader:PreLoader;
		private var listeners:Listeners;
		
		public function bringTheBigGun() {
			this.preLoader = new PreLoader(this.stage);
			this.listeners = new Listeners(this.stage,this.preLoader);
			this.preLoader.listeners = this.listeners;
		}
		
	}
	
}
