require 'dbi'
require 'net/ping'

# The Net module serves as a namespace only.
module Net

   # The Ping::TNS class encapsulates the information and behavior of tns ping.
   class Ping::TNS < Ping::TCP

      # The error class typically raised if any of the Ping::TNS methods fail.
      class Error < StandardError; end

      # The version of the net-tnsping library.
      VERSION = '1.3.1'

      # Database name.
      attr_accessor :db

      # Database source name.
      attr_accessor :dsn

      # The full path to the tnsnames.ora file.
      attr_accessor :tns_file

      # The name of the host the database sits on.
      attr_accessor :host

      # The toplevel tns admin path.
      attr_accessor :tns_admin

      # The value of your ORACLE_HOME or ORA_HOME environment variable.
      attr_accessor :ora_home

      # The name of the oracle driver to use for connections. Defaults to OCI8.
      attr_accessor :driver

      # The timeout value for connection attempts. The default is 5 seconds.
      attr_accessor :timeout

      # A list of hosts for the given database name.
      attr_reader :hosts

      # A list of ports for the given database name
      attr_reader :ports

      # The port used when attempting a connection. The default is 1521.
      attr_reader :port

      # Creates and returns a new Ping::TNS object. If the db specified cannot
      # be found in the tnsnames.ora file, then a Ping::TNS::Error is raised.
      #
      def initialize(db, driver='OCI8', host=nil, port=1521, timeout=5)
         @db        = db
         @dsn       = "dbi:#{driver}:" << db
         @host      = host
         @timeout   = timeout
         @port      = port
         @tns_admin = tns_admin
         @ports     = []  # There can be more than one host/port
         @hosts     = []  # for each dsn.  Try them in order.
         @sid       = nil

         @tns_admin = ENV['TNS_ADMIN']
         @ora_home  = ENV['ORACLE_HOME'] || ENV['ORA_HOME']

         if @tns_admin
            @tns_file = File.join(@tns_admin, 'tnsnames.ora')
         elsif @ora_home
            @tns_file = File.join(@ora_home, 'network', 'admin', 'tnsnames.ora')
         else
            @tns_file = File.join((ENV['HOME'] || ENV['USERPROFILE']), 'tnsnames.ora')
         end

         yield self if block_given?

         # If the host is not specified, look for it in the tnsnames.ora file
         if host.nil?
            err_msg = "tnsnames.ora file could not be found"
            raise Error, err_msg unless File.exists?(@tns_file)
            parse_tns_file
         else
            @hosts.push(host)
            @ports.push(port)
         end
      end

      # Sets the port that the Ping::TNS#ping_listener? method will use.  If
      # this is set, then a ping will only be attempted on this port,
      # regardless of what is in the tnsnames.ora file.
      #
      def port=(num)
         @port = num
         @ports = [num]
      end

      # Performs a TCP ping on the listener. The host and port are determined from
      # your tnsnames.ora file. If more than one host and/or port are found in the
      # tnsnames.ora file, then each will be tried.  So long as at least one of
      # them connects successfully, true is returned. 
      #
      # If you specify a host and port in the constructor, then the attempt will
      # only be made against that host on the given port.
      #--
      # Try each host/port listed for a given entry.  Return a true result if
      # any one of them succeeds and break out of the loop.
      #
      def ping?
         if @hosts.empty?
            raise Error, "No hosts found"
         end

         # Use 1521 if no ports were found in the tnsnames.ora file.
         if @ports.empty?
            @ports.push(@port)
         end

         # If the host is provided, only ping that host
         if @host
            0.upto(@ports.length-1){ |n|
               @port = @ports[n]
               return super
            }
         else
            0.upto(@ports.length-1){ |n|
               @port = @ports[n]
               @host = @hosts[n]
               return super
            }
         end
      end

      # Attempts to make a connection using a bogus login and password via the
      # DBI class.  If an ORA-01017 Oracle error is returned, that means the
      # database is up and running and true is returned.
      #
      # Note that each of the arguments for this method use the defaults
      # passed to the constructor (or have a default otherwise set).  You
      # generally should not pass any arguments to this method.
      # In the event that this method fails, false is returned and the error
      # can be viewed via Ping::TNS#exception.
      #--
      # I have intentionally set the user and password to something random in
      # order to avoid the possibility of accidentally guessing them.  In
      # case of cosmic coincidence, set them yourself.
      #
      def ping_database?(dsn=@dsn, timeout=@timeout, user=@sid, passwd=Time.now.to_s)
         re   = /ORA-01017/
         dbh  = nil
         user ||= Time.now.to_s
         rv = false
         begin
            Timeout.timeout(timeout){
               dbh = DBI.connect(dsn,user,passwd)
            }
         rescue DBI::DatabaseError => e
            if re.match(e.to_s)
               rv = true
            else
               @exception = e
            end
         rescue Timeout::Error, StandardError => e
            @exception = e
         ensure
            if dbh
               dbh.disconnect if dbh.connected?
            end
         end
         rv
      end

      # Simple wrapper for ping_listener? + ping_database?
      #
      def ping_all?
         return false unless self.ping_listener?
         return false unless self.ping_database?
         true
      end

      private

      # parse_tns_file
      #
      # Search for the dsn entry within the tnsnames.ora file and get the host
      # and port information.  Private method.
      #
      def parse_tns_file(file=@tns_file, db=@db)
         re_blank      = /^$/
         re_comment    = /^#/
         re_tns_sentry = /^#{db}.*?=/                 # specific entry
         re_tns_gentry = /^\w.*?=/                    # generic entry
         re_tns_pair   = /\w+\s*\=\s*[\w\.]+/         # used to parse key=val
         re_keys       = /\bhost\b|\bport\b|\bsid\b/i 

         data_string = ""
         found       = false

         IO.foreach(file){ |line|
            next if re_blank.match(line)
            next if re_comment.match(line)
            line.chomp!

            # Skip over lines until an entry for the db is found.
            match = re_tns_sentry.match(line)
            if match
               found = true
               data_string << match.post_match # slurp the rest of the line
               next
            end

            # Once found, slurp the lines into a variable until the next
            # db entry is encountered.
            if found
               break if re_tns_gentry.match(line)
               line.strip!
               data_string << line
            end
         }

         unless found
            raise Error, "unable to find '#{db}' in #{file}"
         end

         # Break each 'key = value' line into its parts
         data_string.scan(re_tns_pair).each{ |pair|
            key, value = pair.split("=")
            key.strip!
            value.strip!
            next unless re_keys.match(key)
            case key.downcase
               when 'host'
                  @hosts.push(value)
               when 'port'
                  @ports.push(value.to_i)
               when 'sid'
                  @sid = value
            end
         }
      end

      alias database db
      alias database_source_name dsn
      alias ping_listener? ping?
      alias oracle_home ora_home
      alias oracle_home= ora_home=
   end
end
