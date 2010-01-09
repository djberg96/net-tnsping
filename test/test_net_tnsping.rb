########################################################################
# test_tns_ping.rb
#
# Test suite for the net-tnsping library. This should be run via the
# 'rake test' task.
########################################################################
require 'rubygems'
gem 'test-unit'

require 'test/unit'
require 'net/tnsping'
include Net

class TC_TNS_Ping < Test::Unit::TestCase
   def self.startup
      @@database = 'change_me' # Change to a valid host name
      @@hostname = Socket.gethostname
   end

   def setup
      if @@database == 'change_me'
         @tnsp = Ping::TNS.new(@@database, 'OCI8', @@hostname)
      else
         @tnsp = Ping::TNS.new(@@database)
      end
   end
   
   def test_version
      assert_equal('1.3.1', Ping::TNS::VERSION)
   end

   def test_db_get
      assert_respond_to(@tnsp, :db)
      assert_nothing_raised{ @tnsp.db }
      assert_equal(@@database, @tnsp.db)
   end

   def test_db_set
      assert_respond_to(@tnsp, :db=)
      assert_nothing_raised{ @tnsp.db = 'fubar' }
      assert_equal('fubar', @tnsp.db)
   end

   def test_dsn_get
      assert_respond_to(@tnsp, :dsn)
      assert_nothing_raised{ @tnsp.dsn }
      assert_equal("dbi:OCI8:#{@@database}", @tnsp.dsn)
   end

   def test_dsn_set
      assert_respond_to(@tnsp, :dsn=)
      assert_nothing_raised{ @tnsp.dsn = 'dbi:OCI8:fubar' }
      assert_equal('dbi:OCI8:fubar', @tnsp.dsn)
   end

   def test_port_get
      assert_respond_to(@tnsp, :port)
      assert_equal(1521, @tnsp.port)
   end

   def test_port_set
      assert_respond_to(@tnsp, :port=)
      assert_nothing_raised{ @tnsp.port = 1555 }
      assert_equal(1555, @tnsp.port)
   end

   def test_ports
      assert_respond_to(@tnsp, :ports)
      assert_kind_of(Array, @tnsp.ports)
      assert(@tnsp.ports.length > 0)
   end

   def test_host_get
      assert_respond_to(@tnsp, :host)
      assert_equal(@@hostname, @tnsp.host)
   end

   def test_host_set
      assert_respond_to(@tnsp, :host=)
      assert_nothing_raised{ @tnsp.host = 'fubar' }
      assert_equal('fubar', @tnsp.host)
   end

   def tests_hosts
      assert_respond_to(@tnsp, :hosts)
      assert_kind_of(Array, @tnsp.hosts)
      assert(@tnsp.hosts.length > 0)
   end

   def test_tns_file_get
      assert_respond_to(@tnsp, :tns_file)
      omit_if(@@database == 'change_me', 'tns_file test skipped without real database')
      assert_true(File.exist?(@tnsp.tns_file))
   end

   def test_tns_file_set
      assert_respond_to(@tnsp, :tns_file=)
      assert_nothing_raised{ @tnsp.tns_file = 'fu_tnsnames.ora' }
      assert_equal('fu_tnsnames.ora', @tnsp.tns_file)
   end

   def test_oracle_home_get
      assert_respond_to(@tnsp, :oracle_home)
      assert_kind_of([String, NilClass], @tnsp.oracle_home)
   end

   def test_oracle_home_set
      assert_respond_to(@tnsp, :oracle_home=)
      assert_nothing_raised{ @tnsp.oracle_home = ENV['HOME'] }
      assert_equal(ENV['HOME'], @tnsp.oracle_home)
   end

   def test_tns_admin_get
      assert_respond_to(@tnsp, :tns_admin)
      assert_kind_of([String, NilClass], @tnsp.tns_admin)
   end

   def test_tns_admin_set
      assert_respond_to(@tnsp, :tns_admin=)
      assert_nothing_raised{ @tnsp.tns_admin = ENV['HOME'] }
      assert_equal(ENV['HOME'], @tnsp.tns_admin)
   end

   def test_ping_listener
      assert_respond_to(@tnsp, :ping?)
      assert_nothing_raised{ @tnsp.ping? }
      omit_if(@@database == 'change_me', 'ping listener test skipped without real database')
      assert_equal(true, @tnsp.ping?)
   end

   def test_ping_database
      assert_respond_to(@tnsp, :ping_database?)
      assert_nothing_raised{ @tnsp.ping_database? }
      omit_if(@@database == 'change_me', 'ping database test skipped without real database')
      assert_equal(true, @tnsp.ping_database?)
   end

   def test_ping_all
      assert_respond_to(@tnsp, :ping_all?)
      assert_nothing_raised{ @tnsp.ping_all? }
      omit_if(@@database == 'change_me', 'ping all test skipped without real database')
      assert_equal(true, @tnsp.ping_all?)
   end

   def test_bad_db
      assert_raises(Ping::TNS::Error){ Ping::TNS.new('bogus_db') }
      @tnsp.port = 9999
      assert_equal(false, @tnsp.ping_listener?)
   end

   def teardown
      @tnsp = nil
   end

   def self.shutdown
      @@database = nil
   end
end
