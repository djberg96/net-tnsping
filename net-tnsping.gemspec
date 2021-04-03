require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'net-tnsping'
  spec.version    = '1.3.4'
  spec.license    = 'Artistic 2.0'
  spec.author     = 'Daniel J. Berger'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'http://github.com/djberg96/net-tnsping'
  spec.summary    = 'A library for pinging Oracle listeners and databases'
  spec.test_file  = 'test/test_net_tnsping.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = Dir['certs/*']

  spec.add_dependency('net-ping')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit')

  spec.description = <<-EOF
    The net-tnsping library provides a way to ping Oracle databases and
    ensure that they're up and running. Unlike the tnsping command line
    program, which only pings the listener, the net-tnsping library
    pings both the listener and the database itself.
  EOF
end
