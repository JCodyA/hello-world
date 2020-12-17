package  {
	/*Copyright 2012 Cody Arnholt, all rights reserved*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Stage;
	
	public class Pig extends MovieClip{
		public var xspeed:Number;
		public var yspeed:Number;
		private var baseSpeed:Number = 3;
		private var rotationSpeed:int;
		private var thump:Thump;
		private var fxForm:SoundTransform;
		private var fxChan:SoundChannel;
		private var isPaused:Boolean = false;
		private var mute:Boolean = false;

		public function Pig(stageRef:Stage) {
			thump = new Thump();
			fxForm = new SoundTransform();
			fxChan = new SoundChannel();
			fxForm.volume = .1;
			this.x = 730;
			this.y = Math.random()*350 +25;
			resetSpeed(null);
			rotationSpeed = randomNegative()*(Math.random()*50 +1);
			addEventListener(Event.EXIT_FRAME, reverseSpeed);
			addEventListener(Event.ENTER_FRAME, movePig);
			stageRef.addEventListener(ControlEvent.onPause,onPause,false,0,true);
			stageRef.addEventListener(ControlEvent.resetSpeed,resetSpeed,false,0,true);
			stageRef.addEventListener(ControlEvent.pigSpeedUp,speedUp,false,0,true);
			stageRef.addEventListener(ControlEvent.toggleMute,toggleMute,false,0,true);
			stageRef.addEventListener(ControlEvent.invisPig,invisPig,false,0,true);
		}
		private function movePig(e:Event):void {
			if (this.isPaused == false && this.visible == true) {
				this.x -= xspeed;
				this.y += yspeed;
				this.rotation += rotationSpeed;
			}
		}
		private function reverseSpeed(e:Event):void {
			if ((y > 400 && yspeed > 0) || (y < 0 && yspeed < 0)) {
				yspeed *= -1;
				this.rotationSpeed = randomNegative()*Math.random()*50 + 1;
				/*if (this.visible == true && mute == false) {
					fxChan = thump.play();
					fxChan.soundTransform = fxForm;
				}*/
			}
			if ((x < 0 && xspeed > 0) || (x > 700 && xspeed < 0)) {
				xspeed *= -1;
				this.rotation = randomNegative()*Math.random()*50 + 1;
				/*if (this.visible == true && mute == false) {	
					fxChan = thump.play();
					fxChan.soundTransform = fxForm;//must do this line after chan = sound.play() line
				}*/
			}
		}
		private function randomNegative():int {
			if (Math.round(Math.random()) == 0) {
				return 1;
			} else {
				return -1;
			}
		}
		/*public function removePig():void {
			if (this.parent != null) {
				this.removeEventListener(Event.ENTER_FRAME, movePig);
				this.removeEventListener(Event.EXIT_FRAME, reverseSpeed);
				this.parent.removeChild(this);
			}
		}*/
		
		public function speedUp(e:ControlEvent):void {
			this.baseSpeed += .3;
			if (this.xspeed < 0) {
				this.xspeed = -(Math.random()*baseSpeed + 1);
			} else {
				this.xspeed = Math.random()*baseSpeed + 1;
			}
			if (this.yspeed < 0) {
				this.yspeed = -(Math.random()*baseSpeed + 1);
			} else {
				this.yspeed = Math.random()*baseSpeed + 1;
			}
		}
		
		public function resetSpeed(e:ControlEvent):void {
			this.xspeed = Math.random()*4 + 1;
			this.yspeed = Math.random()*4 + 1;
			this.baseSpeed = 3
		}
		
		public function onPause(e:ControlEvent):void {
			switch (this.isPaused) {
				case true:
					this.isPaused = false;
					break;
				case false:
					this.isPaused = true;
					break;
			}
		}
		
		public function toggleMute(e:ControlEvent):void {
			if (this.mute == false) {
				this.mute = true;
			} else {
				this.mute = false;
			}
		}
	
		private function invisPig(e:ControlEvent):void {
			this.visible = false;
		}

	}
	
}
