package  {
	import flash.geom.Point;
	
	public class Particle extends Point{
		public var next:Particle;
		public var rise:Number;
		public var alpha:uint = Math.random()*0xff;
		
		public function Particle() {
			this.x = Math.random()*49;
			this.y = 25;
			this.rise = Math.random();
			this.rise *= randomNegative();
		}
		private function randomNegative():int {
			if (Math.round(Math.random()) == 0) {
				return 1;
			} else {
				return -1;
			}
		}

	}
	
}
