package  {
	import flash.events.Event;
	
	public class TogglePauseEvent extends Event{
		public static const togglePause:String = "togglePause";
		
		public function TogglePauseEvent() {
			super("togglePause",false,false);
		}

	}
	
}
