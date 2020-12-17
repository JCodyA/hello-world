package  {
	import flash.events.Event;
	
	public class ControlEvent extends Event{
		public static const beamSpeedUp:String = "beamSpeedUp";
		public static const pigSpeedUp:String = "pigSpeedUp";
		public static const ironPigSpeedUp:String = "ironPigSpeedUp";
		public static const onPause:String = "onPause";
		public static const resetSpeed:String = "resetSpeed";
		public static const invisPig:String = "invisPig";
		public static const invisBeam:String = "invisBeam";
		public static const invisIronPig:String = "invisIronPig";
		public static const invisExplosions:String = "invisExplosions";
		public static const invisMenus:String = "invisMenus";
		public static const toggleMute:String = "toggleMute";
		public static const resetBeamSize:String = "resetBeamSize";

		public function ControlEvent(type:String) {
			super(type,true,false);
		}

	}
	
}
