require 'net/http'
require 'json'

module SocketioEmitter
  class Client
    # Set the server and uri
    def initialize(server=false)
      @server = SocketioEmitter.server || server
      @uri = URI.parse(@server)
    end

    # Connect
    def connect
      @socketio = init_socketio
      res = receive  # Initial receive for the handshake
      if res == '1::'
        @connected = true
        res
      else
        @connected = false
      end
    end

    # Emit a one-off message
    def emit(event,msg)
      connect
      # Define the payload
      payload = {
        :name => event,
        :args => [msg]
      }
      res = send "5:::#{payload.to_json}"
      close
      res
    end

    # Close the connection
    def close
      res = send '0::' if @connected
      @socketio = nil
      @connected = false
      true
    end

    # Send data to the session
    def send(data)
      # Send the payload via xhr-polling
      http = Net::HTTP.new(@uri.host, @uri.port)
      request = Net::HTTP::Post.new "/socket.io/1/xhr-polling/#{@socketio.first}?t=#{Time.now.to_i}"
      request.body = data
      response = http.request(request)
      response.code == "200" ? response.body : false
    end

    # Receive a response from the session
    def receive
      uri = URI.parse("#{@uri.scheme}://#{@uri.hostname}:#{@uri.port}/socket.io/1/xhr-polling/#{@socketio.first}?t=#{Time.now.to_i}")
      response = Net::HTTP.get_response(uri)
      response.code == "200" ? response.body : false
    end

    # Get the initialization from socket.io
    def init_socketio
      root = @uri.clone
      root.path = '/socket.io/1'
      resp = Net::HTTP.get_response(root)
      if resp.code == "200"
        data = resp.body.split(':')
        data[-1] = data[-1].split(',')
        data
      else
        false
      end
    end
  end
end
