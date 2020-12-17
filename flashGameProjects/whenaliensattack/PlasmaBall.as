package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class PlasmaBall extends MovieClip {
		
		private var speed = 15;
		
		public function PlasmaBall() {
			this.addListeners();
		}
		
		private function addListeners(){
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function setX(x:Number) {
			this.x = x;
		}
		
		public function setY(y:Number) {
			this.y = y;
		}
		
		public function setVisibility(bool:Boolean){
			this.visible = bool;
		}
		
		private function onEnter(e:Event){
			if (this.visible) {
				this.move();
			}
		}
		
		private function move() {
			this.y -= speed;
			if (this.y < -10) {
				this.setVisibility(false);
			}
		}
		
	}
	
}
