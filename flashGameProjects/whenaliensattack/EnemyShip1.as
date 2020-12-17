package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class EnemyShip1 extends MovieClip {
		
		private var dx:Number;
		private var dy:Number;
		private var motion:String = "default";
		private var speed:int = 1;
		
		public function EnemyShip1(xPos:Number,yPos:Number) {
			this.addListeners();
			this.setMotion(motion);
			this.setVisibility(false);
		}
		
		public function setMotion(type:String){
			switch (type){
				case "default":
					this.motion="default"
					break;
				case "linear":
					this.motion="linear"
					break;
				case "sine":
					this.motion="sine"
					break;
			}
		}
		
		private function addListeners() {
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event){
			if (this.visible) {
					switch (motion) {
						case "default":
						this.defaultMove();
						break;
			
					}
			}
		}
		
		private function defaultMove() {
			dy = speed*2;
			this.y += dy;
			if (this.y > 525) {
				this.y = -10;
				this.setVisibility(false);
			}
		}
		
		public function setVisibility(bool:Boolean) {
			this.visible = bool;
		}
		
	}
	
}
