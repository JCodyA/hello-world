package  {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class PreloaderPig extends MovieClip{
		private var stageRef:Stage;

		public function PreloaderPig(stageRef:Stage) {
			this.x = 350;
			this.y = 200;
			this.stageRef = stageRef;
			this.alpha = 0;
			this.addEventListener(Event.ENTER_FRAME, loading);
		}
		
		function loading(e:Event):void{
			var total:Number = this.stageRef.loaderInfo.bytesTotal;
			var loaded:Number = this.stageRef.loaderInfo.bytesLoaded;
			this.alpha = loaded/total;
			this.loadedText.text = Math.floor((loaded/total)*100).toString() + "%";
		}		

	}
	
}
