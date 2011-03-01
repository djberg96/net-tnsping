require 'rubygems'

Gem::Specification.new do |spec|
  spec.name      = 'net-tnsping'
  spec.version   = '1.3.2'
  spec.license   = 'Artistic 2.0'
  spec.author    = 'Daniel J. Berger'
  spec.email     = 'djberg96@gmail.com'
  spec.homepage  = 'http://www.rubyforge.org/projects/shards'
  spec.summary   = 'A library for pinging Oracle listeners and databases'
  spec.test_file = 'test/test_net_tnsping.rb'
  spec.has_rdoc  = true
  spec.files     = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.rubyforge_project = 'shards'
  spec.extra_rdoc_files  = ['CHANGES', 'MANIFEST', 'README']

  spec.add_dependency('net-ping', '>= 1.4.0')
  spec.add_development_dependency('test-unit', '>= 2.1.2')

  spec.description = <<-EOF
    The net-tnsping library provides a way to ping Oracle databases and
    ensure that they're up and running. Unlike the tnsping command line
    program, which only pings the listener, the net-tnsping library
    pings both the listener and the database itself.
  EOF
end
