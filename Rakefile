require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.log")

namespace :gem do
  desc "Create the net-tnsping gem"
  task :create => [:clean] do
    require 'rubygems/package'
    spec = Gem::Specification.load('net-tnsping.gemspec')
    spec.signing_key = File.join(Dir.home, '.ssh', 'gem-private_key.pem')
    Gem::Package.build(spec)
  end

  desc "Install the net-tnsping gem"
  task :install => [:create] do
    file = Dir['*.gem'].first
    sh "gem install -l #{file}"
  end
end

desc "Run the example program"
task :example do |dsn|
  ruby "-Ilib examples/example_tnsping.rb #{dsn}"
end

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
end

task :default => :test
