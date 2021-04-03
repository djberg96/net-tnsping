## 1.3.4 - 12-Dec-2015
* This gem is now signed.
* Added a net-tnsping.rb file for convenience.
* Updates to Rakefile and gemspec.

## 1.3.3 - 18-Jan-2014
* Now allows hyphens in hostnames. Thanks go to Jérémie Pierson for the
  spot and the patch.
* Minor updates to the Rakefile and test suite.

## 1.3.2 - 1-Mar-2011
* Case is now ignored for the database name when searching through the
  tnsnames.ora file.
* Removed explicit timeout accessor. It's already inherited.
* Fixed the driver accessor. It was not being set in the constructor.
* Removed a useless call to tns_admin in the constructor.
* Flip-flopped the db and database accessor and alias.
* Refactored tests to use declarative syntax, added some tests, and
  did some general refactoring. Also, the default database name is
  set to "XE" (Express Edition). Change as needed.
* Updated the Rakefile, removing the non-gem installation task, and
  adding a clean task.
* Updated the gemspec. The gem build is now handled by a rake task.

## 1.3.1 - 8-Aug-2009
* Switched test-unit from a runtime dependency to a development dependency.
* Minor documentation updates.

## 1.3.0 - 22-Jul-2009
* Removed the old constant aliases. Use Ping::TNS and Ping::TNS::Error.
* Added documentation for individual accessors.
* Added aliases for Ping::TNS#db and Ping::TNS#dsn.
* Bug fix for Ping::TNS#port= where an instance variable wasn't set.
* Updated test suite to use test-unit 2.x features. Added test-unit 2.x as
  a dependency as a result.
* Renamed the example program to avoid any confusion with test files.
* Updated the license to Artistic 2.0.
* Some gemspec updates.

## 1.2.0 - 20-Jul-2007
* Changed the TNSPing class name to Ping::TNS in order to follow the naming
  convention in net-ping. The TNSPingError class was likewise changed to
  Ping::TNS::Error. However, I've setup class aliases for the sake of backwards
  compatability. However, new programs should use the new class names.
* Fixed an initialization warning.
* Added a Rakefile with tasks for testing and installation. This also means
  the install.rb file was removed, since installation is now handled by the
  Rakefile.
* Some updates to the test suite.

## 1.1.0 - 16-Jun-2005
* The prerequisite "net-pingsimple" was changed to "net-ping", because
  that project name changed.
* Added "net-ping" as a dependency to the gemspec.

## 1.0.0 - 7-Jun-2005
* Moved project to RubyForge.
* Added a .gemspec file.
* Bumped the VERSION number.
* Inlined some rdoc code into tnsping.rb.

## 0.2.1 - 18-Apr-2005
* Fixed a bug in the tnsnames.ora parser method for those cases where each
  db entry is on its own line.
* Corrected the date of the last release, and added the 0.1.1 and 0.1.2
  changes back into the CHANGES file.

## 0.2.0 - 12-Apr-2005
* Massive internal refactoring.
* No longer requires that each tnsnames.ora entry be on its own line.
* Much improved documentation.
* Moved the sample program to the 'examples' directory.
* Many more tests added.
* Removed the INSTALL file.  Installation instructions are now included in
  the README file.
* The README and CHANGES files are now rdoc friendly.

## 0.1.2 - 11-Apr-2003
* Fixed a regex bug in the parse_tns_file() method that could cause problems
  retrieving the correct host and/or port.
* Fixed the testsuite up a bit.

## 0.1.1 - 20-Mar-2003
* The default domain/zone from the sqlnet.ora file are automatically appended
  to the check against the tnsnames.ora file (if present).
* Slightly better internal error handling added
* Added VERSION constant and class method
* Some more assertions added, and some minor changes, to the test suite
* rd2 documentation separated from source - now in /doc directory
* Changed CHANGELOG to CHANGES (merely for consistency with my other packages).
* Doc updates

## 0.1.0 - 19-Dec-2002
* Initial Release
