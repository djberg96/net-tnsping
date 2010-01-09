require 'rake'
require 'rake/testtask'

desc "Install the net-tnsping library (non-gem)"
task :install do
   dest = File.join(Config::CONFIG['sitelibdir'], 'net')
   Dir.mkdir(dest) unless File.exists? dest
   cp 'lib/net/tnsping.rb', dest, :verbose => true
end

desc "Install the net-tnsping library as a gem"
task :install_gem do
   ruby 'net-tnsping.gemspec'
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

desc "Run the example program"
task :example do |dsn|
   ruby "-Ilib examples/example_tnsping.rb #{dsn}"end

Rake::TestTask.new do |t|
   t.warning = true
end
