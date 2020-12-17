package  {
	import flash.events.Event;
	import flash.display.Stage;
	import flash.ui.Mouse;	
	import flash.events.MouseEvent;
	import flash.utils.Timer;;
	import flash.events.TimerEvent;
	
	public class Listeners {
		private var objects:PreLoader;
		private var initDelay:int = 500;
		public var stage:Stage;
		private var isShooting:Boolean = false;
		private var shootTimer:Timer;
		private var muzzleFlashTimer:Timer = new Timer(100);

		public function Listeners(stage:Stage,objects:PreLoader) {
			this.stage = stage;
			this.objects = objects;
			this.shootTimer = new Timer(this.initDelay)
			addListeners(this.stage);
			//objects to player
			this.objects.player.setObjects(this.objects);
		}
		
		private function addListeners(stage:Stage) {
			this.shootTimer.addEventListener(TimerEvent.TIMER, onShootTimer);
			this.muzzleFlashTimer.addEventListener(TimerEvent.TIMER, onMuzzleFlashTimer);
			stage.addEventListener(Event.ENTER_FRAME, onEnter);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onEnter(e:Event) {
			updateObjectPositions();
			if (this.isShooting == true && this.shootTimer.running==false) {
				this.objects.player.shoot();
			}
		}
		
		/*private function shoot() {
			this.objects.fire.visible = true;
			this.muzzleFlashTimer.start();
			switch(this.objects.player.shotPath) {
				case "linear":
				this.linearShoot();
				break;
			}
		}*/
		
		private function onMuzzleFlashTimer(e:TimerEvent) {
			this.muzzleFlashTimer.stop();
			this.objects.fire.visible = false;
		}
		
		/*private function linearShoot() {
			switch(this.objects.player.shotType) {
				case "Bullet":
				this.shootTimer.delay = this.objects.player.bulletDelay;
				this.shootTimer.start();
				linearShootBullet();
				break;
				
				case "Beam":
				this.shootTimer.delay = this.objects.player.beamDelay;
				this.shootTimer.start();
				linearShootBeam();
				break;
			}
		}*/
		
		private function onShootTimer(e:TimerEvent) {
			this.shootTimer.stop();
		}
		
		private function updateObjectPositions() {
			this.objects.player.x = stage.mouseX;
			this.objects.player.y = stage.mouseY;
			this.objects.fire.x = stage.mouseX;
			this.objects.fire.y = stage.mouseY;
		}
		
		private function onMouseDown(e:Event) {
			this.isShooting = true;
		}
		
		private function onMouseUp(e:Event) {
			this.isShooting = false;
		}
		
		public function startMuzzleFlashTimer(){
			this.muzzleFlashTimer.start();
		}
		
		public function setShootTimerDelay(delay:int){
			this.shootTimer.delay = delay;
		}
		
		public function startShootTimer(){
			this.shootTimer.start();
		}
		
	}
	
}
