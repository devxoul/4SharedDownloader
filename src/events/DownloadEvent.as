package events
{
	import bindings.Downloading;
	
	import flash.events.Event;
	
	public class DownloadEvent extends Event
	{
		public static const START : String = "start";
		public static const CANCEL : String = "cancel";
		public static const RESTART : String = "restart";
		public static const REMOVE_FROM_LIST : String = "removeFromList";
		public static const REMOVE_FROM_DISK : String = "removeFromDisk";
		
		public var downloading : Downloading;
		
		public function DownloadEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}