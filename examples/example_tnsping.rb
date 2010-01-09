#######################################################################
# example_tnsping.rb
#
# Simple test script. Not required for installation. Modify as you see
# fit. You can run this program via the 'example' rake task.
#######################################################################
require "net/tnsping"

dsn = ARGV[0]

if dsn.nil?
   puts "Usage: ruby test.rb <datasource>"
   exit
end

t = Net::Ping::TNS.new(dsn)

if t.ping_listener?
   puts "Listener ping successful"
else
   puts "Listener ping problems: " + t.exception
end

if t.ping_database?
   puts "Database ping successful"
else
   puts "Database ping problems: " + t.exception
end
