package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class RewardBubble extends MovieClip{

		public function RewardBubble() {
			this.x = 580;
			this.y = 8;
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
