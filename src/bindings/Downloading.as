package bindings
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class Downloading
	{
		public static const STATE_DOWNLOAD : String = "download";
		public static const STATE_COMPLETE: String = "complete";
		public static const STATE_CANCEL : String = "cancel";
		
		[Bindable]
		public var title : String;
		
		[Bindable]
		public var bytesLoaded : int;
		
		[Bindable]
		public var bytesTotal : int;
		
		[Bindable]
		public var currentState : String = STATE_DOWNLOAD;
		
		public var index : int;
		
		private var _downloadFile : File;
		private var _fileStream : FileStream;
		private var _urlStream : URLStream;
		
		private var _url : String;
		private var _localPath : String;
		private var _fileName : String;
		
		public function get url() : String { return _url; }
		public function get localPath() : String { return _localPath; }
		public function get fileName() : String { return _fileName; }
		
		public function Downloading()
		{
			_downloadFile = new File;
			_urlStream = new URLStream;
			_urlStream.addEventListener( ProgressEvent.PROGRESS, onDownloadProgress );
			_urlStream.addEventListener( Event.COMPLETE, onDownloadComplete );
		}
		
		/**
		 * 파일 다운로드를 시작한다.
		 */
		public function startDownload( url : String, localPath : String, fileName : String ) : void
		{
			trace( "download from :", url );
			
			_downloadFile = _downloadFile.resolvePath( localPath + File.separator + fileName );
			_url = url;
			_localPath = localPath;
			_fileName = fileName;
			
			if( _downloadFile.exists )
			{
				Alert.show( "이미 파일이 존재합니다. 덮어씌울까요?", "", Alert.YES | Alert.NO, null, onAlertClose );
				return;
			}
			
			_startDownload();
		}
		
		/**
		 * 파일을 다운로드를 다시 시작한다. 파일이 존재할 경우 무조건 덮어씌운다.
		 */
		public function restartDownload() : void
		{
			currentState = STATE_DOWNLOAD;
			_startDownload();
		}
		
		/**
		 * 파일 다운로드를 취소한다.
		 */
		public function cancelDownload() : void
		{
			currentState = STATE_CANCEL;
			if( _urlStream.connected ) _urlStream.close();
			if( _fileStream ) _fileStream.close();
		}
		
		/**
		 * 파일을 디스크에서 제거한다.
		 */
		public function removeFromDisk() : void
		{
			// 로컬에서 파일을 수동으로 지웠을 경우 에러나는 것 방지
			if( _downloadFile.exists )
				_downloadFile.deleteFile();
		}
		
		/**
		 * 파일 덮어씌우기 여부 얼럿창이 종료되었을 때 실행되는 메서드.
		 */
		private function onAlertClose( e : CloseEvent ) : void
		{
			if( e.detail == Alert.YES ) _startDownload();
			else cancelDownload();
		}
		
		private function _startDownload() : void
		{
			_fileStream = new FileStream;
			_fileStream.openAsync( _downloadFile, FileMode.WRITE );
			
			var urlReq : URLRequest = new URLRequest( _url );
			_urlStream.load( urlReq );
			
			trace( "download at :", _downloadFile.nativePath );
		}
		
		private function onDownloadProgress( e : ProgressEvent ) : void
		{			
//			trace( e.bytesLoaded, "/", e.bytesTotal );
			bytesLoaded = e.bytesLoaded;
			bytesTotal = e.bytesTotal;
			
			var byteArray : ByteArray = new ByteArray;
			_urlStream.readBytes( byteArray, 0, _urlStream.bytesAvailable );
			_fileStream.writeBytes( byteArray, 0, byteArray.bytesAvailable );
		}
		
		private function onDownloadComplete( e : Event ) : void
		{
			currentState = STATE_COMPLETE;
			
			_urlStream.close();
			_fileStream.close();
		}
	}
}