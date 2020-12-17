package  {
	
	import flash.display.MovieClip;	
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Playership extends MovieClip {
		
		private var stageRef:Stage;
		private var speed:int = 5;
		private var dx:Number;
		private var dy:Number;
		private var angle:Number;
		private var plasmaBallArray:Array = new Array;
		private var numPlasmaBalls:uint = 20;
		private var plasmaMarker:uint = 0;
		private var weapon:String = "plasma";
		private var isShooting:Boolean = false;
		private var shotDelay:uint = 300;
		private var shootTimer:Timer = new Timer(shotDelay);
		private var coolDownTimer:Timer = new Timer(shotDelay);
		private var mouseIsDown:Boolean = false;
		
		public function Playership(stageRef:Stage) {
			this.stageRef = stageRef;
			this.x = 275
			this.y = 400;
			this.setupWeapons();
			this.addListeners();
			this.addChildren();
		}
		
		private function addChildren(){
			for (var i=0;i<this.numPlasmaBalls;i++){
				stageRef.addChild(this.plasmaBallArray[i]);
			}
		}
		
		private function setupWeapons(){
			for (var i=0;i<this.numPlasmaBalls;i++){
				var shot = new PlasmaBall;
				this.plasmaBallArray.push(shot);
				shot.setVisibility(false);
			}
		}
		
		private function addListeners() {
			this.addEventListener(Event.ENTER_FRAME, onEnter);
			stageRef.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			stageRef.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this.shootTimer.addEventListener(TimerEvent.TIMER, onShootTime);
			this.coolDownTimer.addEventListener(TimerEvent.TIMER, onCoolDown);
		}
		
		private function onShootTime(e:Event){
			this.shoot(); 
		}
		
		private function onCoolDown(e:Event){
			this.coolDownTimer.stop();
			if (this.mouseIsDown) {
				this.shoot();
				this.shootTimer.start();
				this.isShooting = true;
			}
		}
		
		private function shoot() {
			switch (weapon){
				case "plasma":
				this.plasmaShoot();
				break;
			}
		}
		
		private function onDown(e:Event){
			this.mouseIsDown = true;
			if (!this.shootTimer.running && !this.coolDownTimer.running) {
				this.shoot();
				this.shootTimer.start();
				this.isShooting = true;
			}
		}
		
		private function onUp(e:Event){
			this.mouseIsDown = false;
			if (this.isShooting) {
				this.coolDownTimer.start();
				this.shootTimer.stop();
				this.isShooting = false;
			}
		}
		
		private function plasmaShoot(){
			var shot = this.plasmaBallArray[this.plasmaMarker];
			shot.setVisibility(true);
			shot.setX(this.x);
			shot.setY(this.y-10);
			this.plasmaMarker++;
			if (this.plasmaMarker == this.numPlasmaBalls) {
				this.plasmaMarker = 0;
			}
		}
		
		private function onEnter(e:Event) {
				dx = stage.mouseX - this.x;
				dy = stage.mouseY - this.y;
				if (Math.sqrt(dy*dy + dx*dx) < speed) {
					this.x = stage.mouseX;
					this.y = stage.mouseY;
				} else {
					angle = Math.atan2(dy,dx);
					this.x += Math.cos(angle) * speed;
					this.y += Math.sin(angle) * speed;
				}
		}
		
	}
	
}
