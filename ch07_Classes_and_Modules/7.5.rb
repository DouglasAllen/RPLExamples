# ---------------------------
# 7.5.1.1 Nested namespaces

module Base64
  DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

  class Encoder
    def encode
    end
  end

  class Decoder
    def decode
    end
  end

  # A utility function for use by both classes
  def Base64.helper
  end
end

# ---------------------------
# 7.5.2 Modules As Mixins

class Point
  include Comparable
end

# ---------------------------

class Point
  include(Comparable)
end

# ---------------------------

include Enumerable, Comparable

# ---------------------------

"text".is_a? Comparable         # => true
Enumerable === "text"           # => true in Ruby 1.8, false in 1.9

# ---------------------------

"text".instance_of? Comparable  # => false

# ---------------------------

module Iterable       # Classes that define next can include this module
  include Enumerable          # Define iterators on top of each
  def each                    # And define each on top of next
    loop { yield self.next }
  end
end

# ---------------------------

countdown = Object.new       # A plain old object
def countdown.each           # The each iterator as a singleton method
  yield 3
  yield 2
  yield 1
end
countdown.extend(Enumerable) # Now the object has all Enumerable methods  
print countdown.sort         # Prints "[1, 2, 3]"

# ---------------------------
# 7.5.3 Includable Namespace Modules

Math.sin(0)    # => 0.0: Math is a namespace 
include Math # The Math namespace can be included
sin(0)         # => 0.0: Now we have easy access to the functions

# ---------------------------