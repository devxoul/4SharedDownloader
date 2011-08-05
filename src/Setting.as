package
{
	import flash.net.SharedObject;

	public class Setting
	{	
		private static var _sharedObj : SharedObject;
		
		public function Setting()
		{
			if( _sharedObj ) throw( new Error( "Setting class cannot be instantiated." ) );
		}
		
		private static function instantiate() : void
		{
			_sharedObj = SharedObject.getLocal( "4SharedDownloader" );
		}
		
		public static function getSetting( key : String ) : Object
		{
			if( !_sharedObj ) instantiate();
			return _sharedObj.data[key];
		}
		
		public static function setSetting( key : String, value : Object, flush : Boolean = true ) : void
		{
			if( !_sharedObj ) instantiate();
			_sharedObj.data[key] = value;
			if( flush ) _sharedObj.flush();
		}
		
		public static function clearSetting( key : String, flush : Boolean = true ) : void
		{
			if( !_sharedObj ) instantiate();
			delete _sharedObj.data[key];
			if( flush ) _sharedObj.flush();
		}
	}
}