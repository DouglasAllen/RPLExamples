# 6.5.3 The Arity of a Proc

puts lambda{||}.arity        # => 0. No arguments expected
puts lambda{|x| x}.arity     # => 1. One argument expected
puts lambda{|x,y| x+y}.arity # => 2. Two arguments expected
# ---------------------------
puts lambda {|*args|}.arity        # => -1.  ~-1 = -(-1)-1 = 0 arguments required
puts ~lambda {|*args|}.arity 
puts lambda {|first, *rest|}.arity # => -2.  ~-2 = -(-2)-1 = 1 argument required
puts ~lambda {|first, *rest|}.arity
# ---------------------------
puts lambda {}.arity  # &#x2013;1 in Ruby 1.8; 0 in Ruby 1.9