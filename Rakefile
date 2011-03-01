require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.log")

namespace :gem do
  desc "Install the net-tnsping library as a gem"
  task :install_gem do
    spec = eval(IO.read('net-tnsping.gemspec'))
    file = Dir["*.gem"].first
    sh "gem install #{file}"
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
