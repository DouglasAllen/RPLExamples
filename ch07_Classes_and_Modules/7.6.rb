# ---------------------------
# 7.6.1 The Load Path

$LOAD_PATH
# /usr/lib/site_ruby/1.8
# /usr/lib/site_ruby/1.8/i386-linux
# /usr/lib/site_ruby
# /usr/lib/ruby/1.8
# /usr/lib/ruby/1.8/i386-linux
# .

# ---------------------------

# /usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/lib
# /usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/bin
# /usr/local/lib/ruby/site_ruby/1.9
# /usr/local/lib/ruby/site_ruby/1.9/i686-linux
# /usr/local/lib/ruby/site_ruby
# /usr/local/lib/ruby/vendor_ruby/1.9
# /usr/local/lib/ruby/vendor_ruby/1.9/i686-linux
# /usr/local/lib/ruby/vendor_ruby
# /usr/local/lib/ruby/1.9
# /usr/local/lib/ruby/1.9/i686-linux
# .

# ---------------------------

# Remove the current directory from the load path
$:.pop if $:.last == '.'  

# Add the installation directory for the current program to 
# the beginning of the load path
$LOAD_PATH.unshift File.expand_path($PROGRAM_NAME)

# Add the value of an environment variable to the end of the path
$LOAD_PATH << ENV['PATH']

# ---------------------------
# 7.6.2.1 Wrapped loads

require 'erb'
$Util = ERB::Util   # Store a reference to this module in a global variable

# ---------------------------

if Module.nesting.size > 0       # If we're loaded into a wrapper module
  $wrapper = Module.nesting[0]   # Pass the module back to the loading code
end

# ---------------------------
# 7.6.3 Autoloading Modules

# Require 'socket' if and when the TCPSocket is first used
autoload :TCPSocket, "socket"

# ---------------------------