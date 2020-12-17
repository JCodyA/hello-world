package  {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Stage;
	
	public class Level extends MovieClip{
		
		private var player:Playership;
		private var stageRef:Stage;
		private var enemy1Array:Array = new Array();
		private var enemy1Count:int = 20;
		private var enemy1Time:int = 5000;
		private var enemy1Timer:Timer = new Timer(enemy1Time);
		private var enemy1Marker:int = 0;

		public function Level(level:int,stageRef:Stage) {
			this.stageRef = stageRef;
			this.player = new Playership(stageRef);			
			this.setupEnemies();
			this.setupLevel(level);
			this.addChildren();
		}
		
		private function addChildren() {
			stageRef.addChild(this.player);
			for (var i=0;i<enemy1Count;i++) {
				stageRef.addChild(this.enemy1Array[i]);
			}
		}
		
		private function setupLevel(level:int) {
			switch (level) {
				case 1:
				this.level1();
				break;
			}
		}
		
		private function setupEnemies(){
			for (var i=0;i<this.enemy1Count;i++){
				this.enemy1Array.push(new EnemyShip1(this.randNum(0,500),-10));
			}
		}
		
		private function level1(){
			this.enemy1Timer.addEventListener(TimerEvent.TIMER,onEnemy1Timer);
			this.enemy1Timer.start();
		}
		
		private function randNum(lower:Number,upper:Number){
			return Math.round(Math.random()*((upper - lower + 1) + lower));
		}
		
		private function onEnemy1Timer(e:TimerEvent){
			var enemy = this.enemy1Array[this.enemy1Marker];
			enemy.setVisibility(true);
			enemy.x = this.randNum(0,500);
			this.enemy1Marker += 1;
			if (this.enemy1Marker == this.enemy1Count) {
				this.enemy1Marker = 0;
			}
		}

	}
	
}