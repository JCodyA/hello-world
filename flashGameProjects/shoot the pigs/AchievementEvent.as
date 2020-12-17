package  {
	import flash.events.Event;

	public class AchievementEvent extends Event{
		
		public static const oinker:String = "oinker";
		public static const slaughterHouse:String = "slaughterHouse";
		public static const makinBacon:String = "makinBacon";
		public static const speedyBacon:String = "speedyBacon";
		public static const superSonicBacon:String = "superSonicBacon";
		public static const lightSpeedBacon:String = "lightSpeedBacon";
		public static const survivalist:String = "survivalist";
		public static const bigBadWolf:String = "bigBadWolf";
		public static const pigocolypse:String = "pigocolypse";
		
		public function AchievementEvent(eventString:String) {
			super(eventString,true,false);
		}

	}
	
}