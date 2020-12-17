package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.display.Stage;
	
	public class WhenAliensAttack extends MovieClip {
		//private var player:Playership = new Playership();
		private var level1:Level;
		private var stageRef:Stage;
		
		public function WhenAliensAttack() {
			this.stageRef = this.stage;
			this.addListeners();
			this.setupLevel1();
			this.addChildren();
		}
		
		private function setupLevel1(){
			this.level1 = new Level(1,this.stageRef);
		}
		
		private function addListeners() {
			this.addEventListener(Event.ENTER_FRAME, onEnter);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		private function addChildren() {
			//addChild(this.player);
			this.addChild(this.level1);
		}
		
		private function onMouseOver(e:MouseEvent) {
			//Mouse.hide();
		}
		
		private function onEnter(e:Event) {
	
		}
		
	}
	
}
