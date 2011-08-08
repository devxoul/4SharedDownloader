package bindings
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;

	public class Song
	{
		[Bindable]
		public var title : String;
		
		[Bindable]
		public var size : String;
		
		[Bindable]
		public var link : String;
		
		public var downloaded : Boolean;
		
		public function Song() {}
	}
}