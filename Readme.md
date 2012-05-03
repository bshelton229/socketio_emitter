## Ruby Socket.io Emitter ##

socketio_emitter is a very small library for emitting socket.io events from client side ruby via xhr-polling.
It allows client side ruby to trigger events on a socket.io server. It currently emits via xhr-polling, so
the socket.io server has to have that transport enabled. Native websocket support could be added easily.

### Usage: ###
    SocketioEmitter.server = 'http://127.0.0.1:9090'
    SocketioEmitter.emit 'message', { :data => 'of some kind' }
    => "1"
