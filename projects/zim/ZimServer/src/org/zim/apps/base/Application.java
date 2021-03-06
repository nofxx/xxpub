package org.zim.apps.base;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.stream.IBroadcastStream;
import org.red5.server.api.stream.IPlayItem;
import org.red5.server.api.stream.IPlaylistSubscriberStream;
import org.red5.server.api.stream.IStreamAwareScopeHandler;
import org.red5.server.api.stream.ISubscriberStream;

public class Application extends ApplicationAdapter implements
		IPendingServiceCallback, IStreamAwareScopeHandler {

	private static final Log log = LogFactory.getLog(Application.class);

	@Override
	public boolean appStart(IScope scope) {
		// init your handler here
		log.info("App started" + IScope.ID);
		return true;
	}
//public boolean appConnect(IConnection conn, Object[] params) {
	@Override
	public boolean appConnect(IConnection conn, Object[] params) {
		IServiceCapableConnection service = (IServiceCapableConnection) conn;
		log.info("Client appConnect " + conn.getClient().getId() + " mode "
				+ conn);
		log.info("Stream id: " + getClients().size()); // just a unique number
		log.info("Params...hash..." + params.hashCode());
		log.info("params lenght..." + params.length);
		log.info("params lenght" + params);
		//String a = (String)params[0].toString();
		
		//log.info("test to" + a);
			
		
		if(params[0].equals("marcos") && params[1].equals("rock")) {
			  log.info("daora....marcos");
			  service
				.invoke("setId", new Object[] { conn.getClient().getId() },
						this);
			  
		      return true;
		     
		   } else {
			   log.info("nao eh....marcos");
			   service
				.invoke("wrongPass",null,// new Object[] {params[0].toString()},// new Object[] { conn.getClient().getId() },
						this);
		      return false;
		   }
		//return true;
	}

	@Override
	public boolean appJoin(IClient client, IScope scope) {
		log.info("Client joined app " + client.getId());
		// If you need the connecion object you can access it via.
	//	IConnection conn = Red5.getConnectionLocal();
		IConnection current = Red5.getConnectionLocal();
		Iterator<IConnection> it = scope.getConnections();
			
		while (it.hasNext()) {
			IConnection conn = it.next();
			if (conn.equals(current)) {
			// Don't notify current client
			continue;
		}

			if (conn instanceof IServiceCapableConnection) {
				IServiceCapableConnection service = (IServiceCapableConnection) conn;
				service.invoke("addId",
						new Object[] { conn.getClient().getId() }, this);
				if (log.isDebugEnabled()) {
					log.debug("sending notification to " + conn);
				}
			}
		}
		return true;
	}

	public void appStop(IScope scope){
//		
		log.info("Client get off" + scope.toString());

//		
	}
	
	public void appDisconnect(IConnection conn){
//		
//	IServiceCapableConnection service = (IServiceCapableConnection) conn;
	log.info(">>> appDisconnect " + conn.getClient().getId() + " mode "
			+ conn);
		log.info("Stream id: " + getClients().size()); // just a unique number


	}
	
	public void appLeave(IClient client, IScope scope){
		
	//	IServiceCapableConnection service = (IServiceCapableConnection) conn;
		log.info(">>> appLeave " + client.getId());
		IConnection current = Red5.getConnectionLocal();
		Iterator<IConnection> it = scope.getConnections();
		while (it.hasNext()) {
			IConnection conn = it.next();
			if (conn.equals(current)) {
				// Don't notify current client
				continue;
			}

			if (conn instanceof IServiceCapableConnection) {
				((IServiceCapableConnection) conn).invoke("removeId",
						new Object[] { conn.getClient().getId() }, this);
				if (log.isDebugEnabled()) {
					log.debug("sending notification to " + conn);
				}
			}
		}
	
	//	service.invoke("removeId", new Object[] { conn.getClient().getId() },	this);
		// If youvoi need the connecion object you can access it via.
	//	IConnection conn = Red5.getConnectionLocal();
	///	return true;
		
	}
	public void streamPublishStart(IBroadcastStream stream) {
		// Notify all the clients that the stream had been started
		if (log.isDebugEnabled()) {
			log.debug("stream broadcast start: " + stream.getPublishedName());
		}
		IConnection current = Red5.getConnectionLocal();
		Iterator<IConnection> it = scope.getConnections();
		while (it.hasNext()) {
			IConnection conn = it.next();
			if (conn.equals(current)) {
				// Don't notify current client
				continue;
			}

			if (conn instanceof IServiceCapableConnection) {
				((IServiceCapableConnection) conn).invoke("newStream",
						new Object[] { stream.getPublishedName() }, this);
				if (log.isDebugEnabled()) {
					log.debug("sending notification to " + conn);
				}
			}
		}
	}

	public void streamBroadcastClose(IBroadcastStream stream) {
	}

	public void streamBroadcastStart(IBroadcastStream stream) {
	}

	public void streamPlaylistItemPlay(IPlaylistSubscriberStream stream,
			IPlayItem item, boolean isLive) {
	}

	public void streamPlaylistItemStop(IPlaylistSubscriberStream stream,
			IPlayItem item) {

	}

	public void streamPlaylistVODItemPause(IPlaylistSubscriberStream stream,
			IPlayItem item, int position) {

	}

	public void streamPlaylistVODItemResume(IPlaylistSubscriberStream stream,
			IPlayItem item, int position) {

	}

	public void streamPlaylistVODItemSeek(IPlaylistSubscriberStream stream,
			IPlayItem item, int position) {

	}

	public void streamSubscriberClose(ISubscriberStream stream) {

	}

	public void streamSubscriberStart(ISubscriberStream stream) {
	}

	/**
	 * Get streams. called from client
	 * @return iterator of broadcast stream names
	 */
	public List<String> getStreams() {
		IConnection conn = Red5.getConnectionLocal();
		return getBroadcastStreamNames(conn.getScope());
	}

	/**
	 * Handle callback from service call. 
	 */
	public void resultReceived(IPendingServiceCall call) {
		log.info("Received result " + call.getResult() + " for "
				+ call.getServiceMethodName());
	}

}