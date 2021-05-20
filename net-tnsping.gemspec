require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'net-tnsping'
  spec.version    = '1.3.4'
  spec.license    = 'Artistic-2.0'
  spec.author     = 'Daniel J. Berger'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'http://github.com/djberg96/net-tnsping'
  spec.summary    = 'A library for pinging Oracle listeners and databases'
  spec.test_file  = 'test/test_net_tnsping.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = Dir['certs/*']

  spec.add_dependency('net-ping', '~> 1.7')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit', '~> 3.4')

  spec.metadata = {
    'homepage_uri'      => 'https://github.com/djberg96/net-tnsping',
    'bug_tracker_uri'   => 'https://github.com/djberg96/net-tnsping/issues',
    'changelog_uri'     => 'https://github.com/djberg96/net-tnsping/blob/main/CHANGES.md',
    'documentation_uri' => 'https://github.com/djberg96/net-tnsping/wiki',
    'source_code_uri'   => 'https://github.com/djberg96/net-tnsping',
    'wiki_uri'          => 'https://github.com/djberg96/net-tnsping/wiki'
  }

  spec.description = <<-EOF
    The net-tnsping library provides a way to ping Oracle databases and
    ensure that they're up and running. Unlike the tnsping command line
    program, which only pings the listener, the net-tnsping library
    pings both the listener and the database itself.
  EOF
end
