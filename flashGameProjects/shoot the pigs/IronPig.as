package  {
	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.display.Stage;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class IronPig extends MovieClip{
		private var baseSpeed:Number = 50;
		private var rotationSpeed:int;
		private var thump:Thump;
		private var fxForm:SoundTransform;
		private var fxChan:SoundChannel;
		private var player:PlayerShip;
		private var isPaused:Boolean = false;
		private var mute:Boolean = false;
		private var moveTimer:Timer;
		private var moveDelay:uint;
		private var tweenx:Tween;
		private var tweeny:Tween;
		private var tweenX:Tween;
		private var tweenY:Tween;
		
		public function IronPig(player:PlayerShip,stageRef:Stage) {
			this.player = player;
			moveDelay = Math.random()*50 + 500;
			moveTimer = new Timer(moveDelay);
			thump = new Thump();
			fxForm = new SoundTransform();
			fxChan = new SoundChannel();
			fxForm.volume = .1;
			this.x = 730;
			this.y = Math.random()*350 +25;
			resetSpeed(null);
			rotationSpeed = randomNegative()*(Math.random()*50 +1);
			moveTimer.start();
			moveTimer.addEventListener(TimerEvent.TIMER,movePig);
			addEventListener(Event.ENTER_FRAME,onEframe);
			stageRef.addEventListener(ControlEvent.onPause,onPause,false,0,true);
			stageRef.addEventListener(ControlEvent.resetSpeed,resetSpeed,false,0,true);
			stageRef.addEventListener(ControlEvent.ironPigSpeedUp,speedUp,false,0,true);
			stageRef.addEventListener(ControlEvent.toggleMute,toggleMute,false,0,true);
			stageRef.addEventListener(ControlEvent.invisIronPig,invisIronPig,false,0,true);
		}
		
		private function movePig(e:TimerEvent):void {
			if (this.isPaused == false && this.visible == true) {
				if (this.x > (player.x+5)) {
					tweenx = new Tween(this,"x",Bounce.easeOut,this.x,this.x-baseSpeed,moveDelay/1000,true);
					
				} else if (this.x < (player.x-5)) {
					tweenX = new Tween(this,"x",Bounce.easeOut,this.x,this.x+baseSpeed,moveDelay/1000,true);
					
				}
				if (this.y > (player.y+5)) {
					//this.y -= baseSpeed;
					tweeny = new Tween(this,"y",Bounce.easeOut,this.y,this.y-baseSpeed,moveDelay/1000,true);
					
				} else if (this.y < (player.y-5)) {
					//this.y += baseSpeed;
					tweenY = new Tween(this,"y",Bounce.easeOut,this.y,this.y+baseSpeed,moveDelay/1000,true);
				}
			}
		}
		
		private function onEframe(e:Event):void {
			if (this.isPaused == false && this.visible == true) {
				this.rotation += rotationSpeed;
			}
		}
		
		private function randomNegative():int {
			if (Math.round(Math.random()) == 0) {
				return 1;
			} else {
				return -1;
			}
		}
		
		private function speedUp(e:ControlEvent):void {
			//this.baseSpeed += Math.random()*25;
			if (this.moveDelay > 100) {
				this.moveDelay -= 10;
				moveTimer.delay = this.moveDelay;
			}
		}
		
		private function resetSpeed(e:ControlEvent):void {
			this.moveDelay = Math.random()*50 + 650;
			this.moveTimer.delay = moveDelay;
		}
		
		/*public function removeMe():void {
			if (this.parent != null) {
				this.removeEventListener(Event.ENTER_FRAME, movePig);
				this.parent.removeChild(this);
			}
		}*/
		
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
		
		private function toggleMute(e:ControlEvent):void {
			if (this.mute == false) {
				this.mute = true;
			} else {
				this.mute = false;
			}
		}
		
		private function invisIronPig(e:ControlEvent):void {
			this.visible = false;
		}

	}
	
}
