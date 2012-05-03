require "socketio_emitter/version"
require 'socketio_emitter/client'

module SocketioEmitter
  @@server = false
  
  # Server setter, for the global server
  def self.server=(server)
    @@server = server
  end
  
  # Server getter
  def self.server
    @@server
  end

  # Emit wrapper
  def self.emit(event, msg)
    client = self::Client.new.emit(event,msg)
  end
end
