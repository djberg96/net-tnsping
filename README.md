# MAINTAINER WANTED

I haven't used Oracle or this library for many years. I would like to
turn it over to someone who is. If you are interested please contact me,
and we can discuss transferring the repository.

## Description
The net-tnsping library emulates the Oracle tnsping utility. It pings
both the listener and the datasource.

## Prerequisites
* dbi
* net-ping
* Any of the Oracle database drivers (oracle, oci8, ruby9i, etc)
   
## Installation
`gem install net-tnsping`

## Synopsis
```ruby
require "net/tnsping"
include Net

t = Ping::TNS.new("my_db")

if t.ping?
 puts "Database appears to be up and running"
else
 puts "There was a problem: " + t.exception
end
```

## Constants
`VERSION`

The version number of this library, returned as a String.

## Class Methods
`Ping::TNS.new(db, driver="OCI8", host=nil, port=1521, timeout=5)`

Creates and returns a new Ping::TNS object. If the db specified cannot be
found in the tnsnames.ora file, then a Ping::TNS::Error is raised.

## Instance Methods
`Ping::TNS#db`

Returns the name of the database that the Ping::TNS#ping_database? method
will attempt to connect to.

`Ping::TNS#db=(database)`

Sets the name of the database that the Ping::TNS#ping_database? method
will attempt to connect to.

`Ping::TNS#driver`

Returns the name of the driver used by the Ping::TNS#ping_database? method.
The default is OCI8.

`Ping::TNS#driver=(driver)`

Sets the name of the driver used by the Ping::TNS#ping_database? method.

`Ping::TNS#dsn`

Returns the dsn string that is used by Ping::TNS#ping_database?.

`Ping::TNS#dsn=(string)`

Sets the dsn string that is used by Ping::TNS#ping_database?. It should
be in the form "dbi:driver:database".

`Ping::TNS#host`

Returns the host that the Ping::TNS#ping_listener? call will use. This may
be nil, in which case, the Ping::TNS#hosts method will list which hosts it
will attempt to ping.

`Ping::TNS#host=(host)`

Sets the host that the Ping::TNS#ping_listener? call will use. If this is
set, then a ping will only be attempted against this host, irregardless
of what is in the tnsnames.ora file.

`Ping::TNS#oracle_home`

Returns the path to the oracle home directory. The default is either
`ENV["ORACLE_HOME"]` or `ENV["ORA_HOME"]`.

`Ping::TNS#oracle_home=(path)`

Sets the path to the oracle home directory.

```
Ping::TNS#ping?
Ping::TNS#ping_listener?
```

Performs a TCP ping on the listener. The host and port are determined from
your tnsnames.ora file. If more than one host and/or port are found in the
tnsnames.ora file, then each will be tried.  So long as at least one of
them connects successfully, true is returned. 

If you specify a host and port in the constructor, then the attempt will
only be made against that host on the given port.

`Ping::TNS#ping_database?(dsn=nil, timeout=nil, user=nil, passwd=nil)`

Attempts to make a connection using a bogus login and password via the DBI
class. If an ORA-01017 Oracle error is returned, that means the database
is up and running and true is returned.

Note that each of the arguments for this method use the defaults passed
to the constructor (or have a default otherwise set). You generally
should not pass any arguments to this method.

In the event that this method fails, false is returned and the error can
be viewed via Ping::TNS#exception.

`Ping::TNS#ping_all?`

A shortcut method that merely calls Ping::TNS#ping? and Ping::TNS#ping_database? 
in succession. Returns true if both succeed, false otherwise.

`Ping::TNS#port`

Returns the port that the Ping::TNS#ping_listener? will ping against. This
may be nil, in which case the Ping::TNS#ports method will list which ports
it will attempt to ping against.

`Ping::TNS#port=(num)`

Sets the port that the Ping::TNS#ping_listener? method will use.  If this is
set, then a ping will only be attempted on this port, irregardless of what
is in the tnsnames.ora file.

`Ping::TNS#timeout`

Returns the timeout value used by all internal ping methods.

`Ping::TNS#timeout=(seconds)`

Sets the timeout used by all internal ping methods.

`Ping::TNS#tns_admin`

Returns the path to the tns admin directory. The default is `ENV["TNS_ADMIN"]`.

`Ping::TNS#tns_admin=(path)`

Sets the path to the tns admin directory.

`Ping::TNS#tns_file`

Returns the full path to the tnsnames.ora file.

`Ping::TNS#tns_file=(path)`

Sets the path to the tnsnames.ora file.

## Notes
The Ping::TNS class is a subclass of Ping::TCP.

This is NOT a wrapper for the tnsping utility. It performs two actions.
First, it attempts to ping the database using the appropriate port via TCP.
Then, it attempts to make a connection using a bogus name and password,
looking for error ORA-1017.

### Test Note
You may want to manually tweak one instance variable (@@database) in the
test suite in order to get a more robust set of test results. Set it to
a known database name. By default it uses "XE" (Express Edition).

## Potential Questions
Q: "Why didn't you just wrap a backticked tnsping call?"

A: First, because the output is unpredictable. On two different platforms I
received two different output streams for the same datasource. Who knows
what it's like on other platforms?

Second, tnsping *only* tells you if the listener is up. It doesn't
actually test that the datasource is up and running.

Q: "Why didn't you write an extension using the tnsping source?"

A: Because the source is closed. One Oracle DBA told me that even attempting
to reverse-engineer the source was prohibited and that I should quit wasting
my time.  Well, I wasted my time anyway, and came up with an even better and
more reliable solution.

## Known Bugs
None that I'm aware of. Please log any bug reports on the project page at
http://github.com/djberg96/net-tnsping   

## Acknowledgements
Thanks go to Bryan Stanaway, a former colleague and Oracle DBA who helped me
out with some questions I had.

## Copyright
(C) 2003-2021 Daniel J. Berger
All rights reserved.
	
## Warranty
This package is provided "as is" and without any express or
implied warranties, including, without limitation, the implied
warranties of merchantability and fitness for a particular purpose.
	
## License
Artistic-2.0

## Author
Daniel J. Berger
