########################################################################
# test_tns_ping.rb
#
# Test suite for the net-tnsping library. This should be run via the
# 'rake test' task.
########################################################################
require 'test-unit'
require 'net/tnsping'

class TC_TNS_Ping < Test::Unit::TestCase
  def self.startup
    @@database = 'xe'
    @@username = 'hr'
    @@password = 'hr'
    @@hostname = Socket.gethostname
  end

  def setup
    @tnsp = Net::Ping::TNS.new(@@database)
  end

  test "version number is expected value" do
    assert_equal('1.3.4', Net::Ping::TNS::VERSION)
  end

  test "database reader basic functionality" do
    assert_respond_to(@tnsp, :database)
    assert_nothing_raised{ @tnsp.database }
    assert_equal(@@database, @tnsp.database)
  end

  test "db is an alias for database" do
    assert_respond_to(@tnsp, :db)
    assert_alias_method(@tnsp, :db, :database)
  end

  test "database writer basic functionality" do
    assert_respond_to(@tnsp, :database=)
    assert_nothing_raised{ @tnsp.database = 'fubar' }
    assert_equal('fubar', @tnsp.database)
  end

  test "dsn reader basic functionality" do
    assert_respond_to(@tnsp, :dsn)
    assert_nothing_raised{ @tnsp.dsn }
    assert_equal("dbi:OCI8:#{@@database}", @tnsp.dsn)
  end

  test "database_source_name is an alias for dsn" do
    assert_respond_to(@tnsp, :database_source_name)
    assert_alias_method(@tnsp, :database_source_name, :dsn)
  end

  test "dsn writer basic functionality" do
    assert_respond_to(@tnsp, :dsn=)
    assert_nothing_raised{ @tnsp.dsn = 'dbi:OCI8:fubar' }
    assert_equal('dbi:OCI8:fubar', @tnsp.dsn)
  end

  test "port reader basic functionality" do
    assert_respond_to(@tnsp, :port)
    assert_equal(1521, @tnsp.port)
  end

  test "port writer basic functionality" do
    assert_respond_to(@tnsp, :port=)
    assert_nothing_raised{ @tnsp.port = 1555 }
    assert_equal(1555, @tnsp.port)
  end

  test "ports reader basic functionality" do
    assert_respond_to(@tnsp, :ports)
    assert_kind_of(Array, @tnsp.ports)
    assert(@tnsp.ports.length > 0)
  end

  test "host reader basic functionality" do
    assert_respond_to(@tnsp, :host)
    assert_nil(@tnsp.host)
  end

  test "host writer basic functionality" do
    assert_respond_to(@tnsp, :host=)
    assert_nothing_raised{ @tnsp.host = 'fubar' }
    assert_equal('fubar', @tnsp.host)
  end

  test "hosts reader basic functionality" do
    assert_respond_to(@tnsp, :hosts)
    assert_kind_of(Array, @tnsp.hosts)
    assert(@tnsp.hosts.length > 0)
  end

  test "there is no hosts writer method" do
    assert_raise(NoMethodError){ @tnsp.hosts = %w[foo bar] }
  end

  test "tns_file reader basic functionality" do
    assert_respond_to(@tnsp, :tns_file)
    assert_kind_of(String, @tnsp.tns_file)
    assert_true(File.exist?(@tnsp.tns_file))
  end

  test "tns_file writer basic functionality" do
    assert_respond_to(@tnsp, :tns_file=)
    assert_nothing_raised{ @tnsp.tns_file = 'fu_tnsnames.ora' }
    assert_equal('fu_tnsnames.ora', @tnsp.tns_file)
  end

  test "oracle_home reader basic functionality" do
    assert_respond_to(@tnsp, :oracle_home)
    assert_kind_of([String, NilClass], @tnsp.oracle_home)
  end

  test "ora_home is an alias for oracle_home" do
    assert_respond_to(@tnsp, :ora_home)
    assert_alias_method(@tnsp, :ora_home, :oracle_home)
  end

  test "oracle_home writer basic functionality" do
    assert_respond_to(@tnsp, :oracle_home=)
    assert_nothing_raised{ @tnsp.oracle_home = ENV['HOME'] }
    assert_equal(ENV['HOME'], @tnsp.oracle_home)
  end

  test "ora_home= is an alias for oracle_home=" do
    assert_respond_to(@tnsp, :ora_home=)
    assert_alias_method(@tnsp, :ora_home=, :oracle_home=)
  end

  test "tns_admin reader basic functionality" do
    assert_respond_to(@tnsp, :tns_admin)
    assert_kind_of([String, NilClass], @tnsp.tns_admin)
  end

  test "tns_admin writer basic functionality" do
    assert_respond_to(@tnsp, :tns_admin=)
    assert_nothing_raised{ @tnsp.tns_admin = ENV['HOME'] }
    assert_equal(ENV['HOME'], @tnsp.tns_admin)
  end

  test "timeout reader basic functionality" do
    assert_respond_to(@tnsp, :timeout)
    assert_kind_of(Fixnum, @tnsp.timeout)
  end

  test "timeout writer basic functionality" do
    assert_respond_to(@tnsp, :timeout=)
    assert_nothing_raised{ @tnsp.timeout = 10 }
    assert_equal(10, @tnsp.timeout)
  end

  test "driver reader basic functionality" do
    assert_respond_to(@tnsp, :driver)
    assert_kind_of(String, @tnsp.driver)
  end

  test "driver writer basic functionality" do
    assert_respond_to(@tnsp, :driver=)
    assert_nothing_raised{ @tnsp.driver = "oracle" }
    assert_equal("oracle", @tnsp.driver)
  end

  test "ping_listener? basic functionality" do
    assert_respond_to(@tnsp, :ping_listener?)
    assert_nothing_raised{ @tnsp.ping_listener? }
  end

  test "ping_listener? returns a boolean value" do
    assert_boolean(@tnsp.ping_listener?)
  end

  test "ping? is an alias for ping_listener?" do
  end

  test "ping_database? basic functionality" do
    assert_respond_to(@tnsp, :ping_database?)
    assert_nothing_raised{ @tnsp.ping_database? }
  end

  test "ping_database? returns a boolean value" do
    assert_boolean(@tnsp.ping_database?)
  end

  test "ping_all? basic functionality" do
    assert_respond_to(@tnsp, :ping_all?)
    assert_nothing_raised{ @tnsp.ping_all? }
  end

  test "ping_all? returns a boolean value" do
    assert_boolean(@tnsp.ping_all?)
  end

  test "ping fails against a bogus database" do
    assert_raises(Net::Ping::TNS::Error){ Net::Ping::TNS.new('bogus_db') }
    @tnsp.port = 9999
    assert_false(@tnsp.ping_listener?)
  end

  def teardown
    @tnsp = nil
  end

  def self.shutdown
    @@username = nil
    @@password = nil
    @@database = nil
    @@hostname = nil
  end
end
