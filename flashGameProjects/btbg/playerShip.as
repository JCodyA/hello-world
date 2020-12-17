package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import fl.transitions.Tween;
	import fl.transitions.easing.*
	
	public class playerShip extends MovieClip {
		private var shotPath:String;
		private var bulletDelay:int;
		private var beamDelay:int;
		private var cannonDelay:int;
		private var shotType:String;
		private var objects:PreLoader;
		private var currentBullet:Bullet;
		private var currentBeam:EnergyBlast;
		private var currentCannon:CannonBall;
		
		public function playerShip(shotPath:String="Linear",bulletDelay:int=500,beamDelay:int=250,
								   cannonDelay:int=750,shotType:String="Cannon") {
			this.shotPath = shotPath;
			this.bulletDelay = bulletDelay;
			this.beamDelay = beamDelay;
			this.cannonDelay = cannonDelay;
			this.shotType = shotType;
		}
		
		public function shoot() {
			this.objects.fire.visible = true;
			this.objects.listeners.startMuzzleFlashTimer();
			switch(this.shotPath) {
				case "linear":
				this.linearShoot();
				break;
			}
		}
		
		private function linearShoot() {
			switch(this.shotType) {
				case "Bullet":
				this.objects.listeners.setShootTimerDelay(this.bulletDelay);
				this.objects.listeners.startShootTimer();
				linearShootBullet();
				break;
				
				case "Beam":
				this.objects.listeners.setShootTimerDelay(this.beamDelay);
				this.objects.listeners.startShootTimer();
				linearShootBeam();
				break;
				
				case "Cannon":
				this.objects.listeners.setShootTimerDelay(this.cannonDelay);
				this.objects.listeners.startShootTimer();
				linearShootCannon();
				break;
			}
		}
		
		private function linearShootCannon(){
			this.currentCannon.x = this.objects.listeners.stage.mouseX;
			this.currentCannon.visible = true;
			var myTween:Tween = new Tween(this.currentCannon,
										  "y", 
									      None.easeNone,this.objects.listeners.stage.mouseY-15,
									      this.objects.listeners.stage.mouseY - 700,
										  .5,
										  true)
			this.currentCannon = this.currentCannon.nextCannon;
		}
		
		private function linearShootBullet(){
			this.currentBullet.x = this.objects.listeners.stage.mouseX;
			this.currentBullet.visible = true;
			var myTween:Tween = new Tween(this.currentBullet,
										  "y", 
									      None.easeNone,this.objects.listeners.stage.mouseY-15,
									      this.objects.listeners.stage.mouseY - 700,
										  .5,
										  true)
			this.currentBullet = this.currentBullet.nextBullet;
		}
		
		private function linearShootBeam(){
			this.currentBeam.x = this.objects.listeners.stage.mouseX;
			this.currentBeam.visible = true;
			var myTween:Tween = new Tween(this.currentBeam,
										  "y", 
									      None.easeNone,this.objects.listeners.stage.mouseY-15,
									      this.objects.listeners.stage.mouseY - 700,
										  .5,
										  true)
			this.currentBeam = this.currentBeam.nextBeam;
		}
		
		public function setObjects(objects:PreLoader){
			this.objects = objects;
			this.currentBullet = this.objects.firstBullet;
			this.currentBeam = this.objects.firstBeam;
			this.currentCannon = this.objects.firstCannon;
		}
		
	}
	
}
