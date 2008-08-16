/*
  Zim (c) 2006-2007
  





*/
package comps.classes.zim
{
	import flash.net.NetConnection;
	import flash.net.Responder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent
	import flash.events.Event;
	import flash.events.IEventDispatcher;
		

	[Event(name="success", type="flash.events.Event")]
	[Event(name="failed", type="flash.events.Event")]
	
	public class RedConector extends NetConnection implements IEventDispatcher
	{	
	
/*_________________________________________________________________
*
*       
*                                                           Objects
*__________________________________________________________________
*/	
	
	
		public var myID:Number;
		private var responder:Responder = new Responder(onResult,onFault);
		
/*_________________________________________________________________
*
*       
*                                                       contructor
*__________________________________________________________________
*/
		
		public function RedConector():void {
			super();
		}
		
		override public function connect( url:String, ...args ):void {
	        // waiting for AMF3 on red5  xD
	        this.objectEncoding = flash.net.ObjectEncoding.AMF0;
	        NetConnection.defaultObjectEncoding;
	        
	        // Add status/security listeners
	        this.addEventListener( NetStatusEvent.NET_STATUS, netStatusHandler );
	        this.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
	        this.addEventListener( AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler );
	        this.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler ); 
	               
	        //to auth users
	        var parameters:Array = args;
	        var user:String = args[0];
	        var pass:String = args[1];
	        super.connect( url, user , pass );
   		}

/*_________________________________________________________________
*
*       
*                                                      functions
*__________________________________________________________________
*/

				
		public function setId( id:Number ):* {
			if( isNaN( id ) ) return;
        	myID = id;
        	return "Okay";
        }
        
        public function removeId (id:Number):* {
          	trace ("remove ID:" + id );
        	return "Okay";
        }
        
        public function getStreams():void {
	    	this.call("getStreams", responder);
	    }
	        
	    public function newStream(what:Object):void{
	    	trace (what);
	    }
	    
	    public function streamBroadcastStart(what:String):void{
	    	
	    }
	    
/*_________________________________________________________________
*
*       
*                                                       handlers
*__________________________________________________________________
*/
    
        private function netStatusHandler( event:NetStatusEvent ):void {
           	switch( event.info.code ) {
            	case "NetConnection.Connect.Success":
	                dispatchEvent( new Event( "success" ) );
    		        break;
            	case "NetConnection.Connect.Failed":
	                dispatchEvent( new Event( "failed" ) );
    		        break;            
           		default:
		            break;
        	}
   		}
		
		private function netSecurityError( event:SecurityErrorEvent ):void {
			trace ("error:" + event );
    	}        

    	private function asyncErrorHandler( event:AsyncErrorEvent ):void {

    	}    

	    private function ioErrorHandler( event:IOErrorEvent ):void {

	    }    
  	    
	  	private function onResult(result:Object):void {
        	//	var resultEvent:ResultEvent = new ResultEvent(result,null,null);
        	//  dispatchEvent(resultEvent);
        	var toStr:String = result.toString();
        	trace (toStr);
       		// mostraChat.text +="\n"+ toStr;
        }
            
        public function onFault(fault:Object):void {
        	//var faultEvent:FaultEvent = new FaultEvent(Fault(fault),null,null);
            //dispatchEvent(faultEvent);
            var toStr:String = fault.toString();
        	trace (toStr);
        }
 	}
}