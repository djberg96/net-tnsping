require 'rubygems'

spec = Gem::Specification.new do |gem|
   gem.name      = 'net-tnsping'
   gem.version   = '1.3.1'
   gem.license   = 'Artistic 2.0'
   gem.author    = 'Daniel J. Berger'
   gem.email     = 'djberg96@gmail.com'
   gem.homepage  = 'http://www.rubyforge.org/projects/shards'
   gem.platform  = Gem::Platform::RUBY
   gem.summary   = 'A library for pinging Oracle listeners and databases'
   gem.test_file = 'test/test_net_tnsping.rb'
   gem.has_rdoc  = true
   gem.files     = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.rubyforge_project = 'shards'
   gem.extra_rdoc_files  = ['CHANGES', 'MANIFEST', 'README']

   gem.add_dependency('net-ping', '>= 1.0.0')
   gem.add_development_dependency('test-unit', '>= 2.0.3')

   gem.description = <<-EOF
      The net-tnsping library provides a way to ping Oracle databases and
      ensure that they're up and running. Unlike the tnsping command line
      program, which only pings the listener, the net-tnsping library
      pings both the listener and the database itself.
   EOF
end

Gem::Builder.new(spec).build
