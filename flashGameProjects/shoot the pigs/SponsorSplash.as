package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class SponsorSplash extends MovieClip{
		private var splashTimer:Timer = new Timer(2000);

		public function SponsorSplash() {
			this.x = 350;
			this.y = 200;
			splashTimer.addEventListener(TimerEvent.TIMER,removeMe,false,0,true);
			splashTimer.start();
		}
		
		private function removeMe(e:TimerEvent):void {
			splashTimer.stop();
			this.parent.removeChild(this);
		}

	}
	
}
