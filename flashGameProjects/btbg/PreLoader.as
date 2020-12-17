package  {
	import flash.display.Stage;
	import flash.ui.Mouse;
	import flash.display.Sprite;
	
	public class PreLoader {
		public var player:playerShip;
		public var fire:gunFire;
		public var firstBullet:Bullet;
		public var lastBullet:Bullet;
		public var numBullets:int = 25;//change this to adjust the number of initial bullets
		public var bulletHolder:Sprite = new Sprite();
		public var firstBeam:EnergyBlast;
		public var lastBeam:EnergyBlast;
		public var numBeams:int = 25;//change this to adjust the number of iniatial beams
		public var beamHolder:Sprite = new Sprite();
		public var firstCannon:CannonBall;
		public var lastCannon:CannonBall;
		public var numCannons:int = 25;//change this to adjust the number of iniatial cannons
		public var cannonHolder:Sprite = new Sprite();
		public var listeners:Listeners;

		public function PreLoader(stage:Stage) {
			instantiateObjects(stage);
			addObjects(stage);
			Mouse.hide();
		}
		
		private function instantiateObjects(stage:Stage) {
			this.player = new playerShip("linear",500);
			this.fire = new gunFire();
			this.fire.visible = false;
			createBulletList(numBullets);
			createBeamList(numBeams);
			createCannonList(numCannons);
		}
		
		private function addObjects(stage:Stage) {
			stage.addChild(this.player);
			stage.addChild(this.bulletHolder);
			stage.addChild(this.beamHolder);
			stage.addChild(this.cannonHolder);
			stage.addChild(this.fire);
		}
		//creates a circular linked list of EnergyBlast movie clip objects.  
		private function createBeamList(numBeams:int) {
			this.firstBeam = new EnergyBlast();
			this.beamHolder.addChild(this.firstBeam);
			this.firstBeam.visible = false
			this.firstBeam.nextBeam = new EnergyBlast();
			var currentBeam:EnergyBlast = this.firstBeam.nextBeam;
			for (var i=0;i<numBeams-2;i++) {
				this.beamHolder.addChild(currentBeam);
				currentBeam.visible = false;
				currentBeam.nextBeam = new EnergyBlast();
				currentBeam = currentBeam.nextBeam;
			}
			this.lastBeam = currentBeam;
			this.beamHolder.addChild(this.lastBeam);
			this.lastBeam.visible = false;
			this.lastBeam.nextBeam = this.firstBeam;
		}
		
		//creates a circular linked list of bullet movie clip objects.  
		private function createBulletList(numBullets:int) {
			this.firstBullet = new Bullet()
			this.bulletHolder.addChild(this.firstBullet);
			this.firstBullet.visible = false
			this.firstBullet.nextBullet = new Bullet();
			var currentBullet:Bullet = this.firstBullet.nextBullet;
			for (var i=0;i<numBullets-2;i++) {
				this.bulletHolder.addChild(currentBullet);
				currentBullet.visible = false;
				currentBullet.nextBullet = new Bullet();
				currentBullet = currentBullet.nextBullet;
			}
			this.lastBullet = currentBullet;
			this.bulletHolder.addChild(this.lastBullet);
			this.lastBullet.visible = false;
			this.lastBullet.nextBullet = this.firstBullet;
		}
		
		//create a circular linked list of cannon balls
		private function createCannonList(numCannons:int) {
			this.firstCannon = new CannonBall()
			this.cannonHolder.addChild(this.firstCannon);
			this.firstCannon.visible = false
			this.firstCannon.nextCannon = new CannonBall();
			var currentCannon:CannonBall = this.firstCannon.nextCannon;
			for (var i=0;i<numCannons-2;i++) {
				this.cannonHolder.addChild(currentCannon);
				currentCannon.visible = false;
				currentCannon.nextCannon = new CannonBall();
				currentCannon = currentCannon.nextCannon;
			}
			this.lastCannon = currentCannon;
			this.cannonHolder.addChild(this.lastCannon);
			this.lastCannon.visible = false;
			this.lastCannon.nextCannon = this.firstCannon;
		}

	}
	
}
