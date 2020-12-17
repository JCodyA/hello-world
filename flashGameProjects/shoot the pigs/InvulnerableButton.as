package  {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class InvulnerableButton extends SimpleButton{

		public function InvulnerableButton() {
			this.x = 403.95;
			this.y = 116.7;
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent):void {
			Mouse.cursor = "arrow";
		}
		
		private function onMouseOut(e:MouseEvent):void {
			Mouse.cursor = "auto";
		}

	}
	
}
