package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class InvulnerableBubble extends MovieClip{

		public function InvulnerableBubble() {
			this.x = 480.05;
			this.y = 116.8;
			addEventListener(Event.ENTER_FRAME,eframe);
		}
		
		private function eframe(e:Event):void {
			this.alpha -= .01;
			if (this.alpha <= 0) {
				removeMe();
			}
		}
		
		private function removeMe():void {
			if (this.parent != null) {
				this.removeEventListener(Event.ENTER_FRAME,eframe);
				this.parent.removeChild(this);
			}
		}

	}
	
}
