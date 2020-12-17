package  {
	/*Copyright 2012 Cody Arnholt, all rights reserved*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import ControlEvent;
	import flash.display.Stage;
	import fl.transitions.Fade;
	
	public class PlayerBeam1 extends MovieClip{
		private var xspeed:int;
		private var fxForm:SoundTransform;
		private var fxChan:SoundChannel;
		private var twang:Twang;
		private var isPaused:Boolean = false;

		public function PlayerBeam1(xPos:int,yPos:int,stageRef:Stage) {
			xspeed = 10;
			addEventListener(Event.ENTER_FRAME, moveBeam);
			stageRef.addEventListener(ControlEvent.onPause,onPause,false,0,true);
			stageRef.addEventListener(ControlEvent.resetSpeed,resetSpeed,false,0,true);
			stageRef.addEventListener(ControlEvent.beamSpeedUp,speedUp,false,0,true);
			stageRef.addEventListener(ControlEvent.invisBeam,invisBeam,false,0,true);
			stageRef.addEventListener(ControlEvent.resetBeamSize,resetSize,false,0,true);
			if ((xPos+15) < 700) {
				this.x = xPos + 15;
			} else {
				this.x = 700;
			}
			this.y = yPos;
			twang = new Twang();
			fxForm = new SoundTransform;
			fxChan = new SoundChannel;
			fxForm.volume = .1;
		}
		private function moveBeam(e:Event):void {
			if (isPaused == false && this.visible == true) {
				x += xspeed;
			}
		}
		public function makeSound():void {
			//sounds
			fxChan = twang.play();
			fxChan.soundTransform = fxForm;
		}
		/*public function removeBeam():void {
			if (this.parent != null) {
				this.removeEventListener(Event.ENTER_FRAME, moveBeam);
				this.parent.removeChild(this);
			}
		}*/
		
		private function speedUp(e:ControlEvent):void {
			this.xspeed += 1;
		}
		
		private function resetSpeed(e:ControlEvent):void {
			this.xspeed = 10;
		}
		
		private function onPause(e:ControlEvent):void {
			switch (this.isPaused) {
				case true:
					this.isPaused = false;
					break;
				case false:
					this.isPaused = true;
					break;
			}
		}
		
		private function invisBeam(e:ControlEvent):void {
			this.visible = false;
		}
		
		private function resetSize(e:ControlEvent):void {
			this.width = 18;
			this.height = 4;
		}

	}
	
}
