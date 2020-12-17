package  {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	
	public class NextLevelButton extends MovieClip{
		//for tweening
		private var origWid:Number;
		private var origHei:Number;
		private var tweenWidScale:Number;
		private var tweenHeiScale:Number;
		private var tweenWid:Tween;
		private var tweenHei:Tween;
		
		//CONSTTRUCTOR
		public function NextLevelButton() {
			this.x = 350;
			this.y = 290;
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			//this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			this.addEventListener(Event.ADDED,onAdded);
		}
		
		private function onAdded(e:Event):void {
			origWid = this.width;
			origHei = this.height;
			tweenWidScale = origWid*1.3;
			tweenHeiScale = origHei*1.3;
			this.removeEventListener(Event.ADDED,onAdded);
		}
		
		private function onMouseOver(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			Mouse.cursor = "button";
			tweenWid = new Tween(this,"width",Strong.easeOut,this.width,this.tweenWidScale,.5,true);
			tweenHei = new Tween(this,"height",Strong.easeOut,this.height,this.tweenHeiScale,.5,true);
		}
		
		private function onMouseOut(e:MouseEvent):void {
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			Mouse.cursor = "auto";
			tweenWid = new Tween(this,"width",Strong.easeOut,this.width,this.origWid,.5,true);
			tweenHei = new Tween(this,"height",Strong.easeOut,this.height,this.origHei,.5,true);
		}

	}
	
}
