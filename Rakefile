require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.log")

namespace :gem do
  desc "Create the net-tnsping gem"
  task :create => [:clean] do
    spec = eval(IO.read('net-tnsping.gemspec'))
    if Gem::VERSION < "2.0"
      Gem::Builder.new(spec).build
    else
      require 'rubygems/package'
      Gem::Package.build(spec)
    end
  end

  desc "Install the net-tnsping gem"
  task :install => [:create] do
    file = Dir['*.gem'].first
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
