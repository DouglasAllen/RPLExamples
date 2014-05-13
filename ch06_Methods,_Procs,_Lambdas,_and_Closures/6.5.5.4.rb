# 6.5.5.4 Argument passing to procs and lambdas

p = Proc.new {|x,y| print x,y }
p.call(1)       # x,y=1:     nil used for missing rvalue:  Prints 1nil
puts
p.call(1,2)     # x,y=1,2:   2 lvalues, 2 rvalues:         Prints 12
puts
p.call(1,2,3)   # x,y=1,2,3: extra rvalue discarded:       Prints 12
puts
p.call([1,2])   # x,y=[1,2]: array automatically unpacked: Prints 12
puts

# ---------------------------
l = lambda {|x,y| print x,y }
l.call(1,2)     # This works
puts
# l.call(1)       # Wrong number of arguments
# l.call(1,2,3)   # Wrong number of arguments
# l.call([1,2])   # Wrong number of arguments
l.call(*[1,2])  # Works: explicit splat to unpack the array
puts