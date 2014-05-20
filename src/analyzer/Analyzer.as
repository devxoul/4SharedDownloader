package analyzer
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	public class Analyzer
	{
		private static var _instance : Analyzer;
		private static var _requests : Array;
		
		public function Analyzer()
		{
			if( _instance ) throw new Error( "It is singleton!" );
		}
		
		private static function initialte() : void
		{
			_instance = new Analyzer;
			_requests = [];
		}
		
		public static function request( url : String, param : Object, callback : Function ) : void
		{
			if( !_instance ) initialte();
			if( Const.DEBUGGING ) return;
			
			var urlReq : URLRequest = new URLRequest( url );
			
			var vars : URLVariables = new URLVariables;
			for( var key : String in param )
			{
				vars[key] = param[key];
			}
			
			urlReq.data = vars;
			
			var req : Request = new Request;
			req.loader = new URLLoader( urlReq );
			req.loader.addEventListener( Event.COMPLETE, onLoadComplete );
			req.callback = callback;
			
			_requests.push( req );
		}
		
		private static function onLoadComplete( e : Event ) : void
		{
			var loader : URLLoader = e.target as URLLoader;
			loader.removeEventListener( Event.COMPLETE, onLoadComplete );
			
			for( var i : int = 0, len : int = _requests.length; i < len; i++ )
			{
				var req : Request = _requests[i] as Request;
				
				if( req.loader == loader )
				{
					req.callback( loader.data );
					req.loader = null;
					req.callback = null;
					req = null;
					_requests.splice( i, 1 );
					return;
				}
			}
		}
	}
}

import flash.net.URLLoader;

class Request
{
	public var loader : URLLoader;
	public var callback : Function;
}