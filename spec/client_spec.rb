require 'spec_helper'

describe SocketioEmitter do
  it "Sould be able to send a message to the socket" do
    SocketioEmitter.server = 'http://127.0.0.1:3001'
    response = SocketioEmitter.emit 'message', 'Test from rspec'    
    SocketioEmitter.server.should eq('http://127.0.0.1:3001')
    response.should eq('1')
  end

  it "Should be able to handshake" do
    client = SocketioEmitter::Client.new 'http://127.0.0.1:3001'
    client.connect
    client.init_socketio.should be_a_kind_of(Array)
    client.close.should eq(true)
  end
end
