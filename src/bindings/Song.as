package bindings
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	
	[Bindable]
	public class Song
	{
		public var title : String;
		public var size : String;
		public var url : String; // 해당 곡의 자세한 페이지 url. 이 페이지에서 다운로드 링크를 한번 더 파싱해야함.
		public var downloaded : Boolean;
		
		public function Song() {}
	}
}