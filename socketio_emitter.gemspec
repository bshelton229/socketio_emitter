# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "socketio_emitter/version"

Gem::Specification.new do |s|
  s.name        = "socketio_emitter"
  s.version     = SocketioEmitter::VERSION
  s.authors     = ["Bryan Shelton"]
  s.email       = ["bshelton2@wisc.edu"]
  s.homepage    = ""
  s.summary     = %q{Emit a simple event to a socket.io server}
  s.description = %q{Emit a simple event to a socket.io server, from client side ruby, via xhr-polling.}

  s.rubyforge_project = "socketio_emitter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'json'
end
