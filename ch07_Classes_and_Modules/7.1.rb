
# ---------------------------
# 7.1.1 Creating the Class

class Point
end

# ---------------------------
# 7.1.2 Instantiating a Point

p = Point.new

# ---------------------------

p.class       # => Point
p.is_a? Point # => true

# ---------------------------
# 7.1.3 Initializing a Point

class Point
  def initialize(x,y)
    @x, @y = x, y
  end
end

# ---------------------------

p = Point.new(0,0)

# ---------------------------
# Incorrect code!

class Point
  @x = 0   # Create instance variable @x and assign a default. WRONG!
  @y = 0   # Create instance variable @y and assign a default. WRONG!

  def initialize(x,y)
    @x, @y = x, y   # Now initialize previously created @x and @y.
  end
end

# ---------------------------
# 7.1.4 Defining a to_s Method

class Point
  def initialize(x,y)
    @x, @y = x, y
  end

  def to_s        # Return a String that represents this point
    "(#@x,#@y)"   # Just interpolate the instance variables into a string
  end
end

# ---------------------------

p = Point.new(1,2)   # Create a new Point object
puts p               # Displays "(1,2)"

# ---------------------------
# 7.1.5 Accessors and Attributes

class Point
  def initialize(x,y)
    @x, @y = x, y
  end

  def x           # The accessor (or getter) method for @x
    @x
  end

  def y           # The accessor method for @y
    @y
  end
end

# ---------------------------

p = Point.new(1,2)
q = Point.new(p.x*2, p.y*3)

# ---------------------------

class MutablePoint
  def initialize(x,y); @x, @y = x, y; end

  def x; @x; end       # The getter method for @x
  def y; @y; end       # The getter method for @y

  def x=(value)        # The setter method for @x
    @x = value
  end

  def y=(value)        # The setter method for @y
    @y = value
  end
end

# ---------------------------

class Point
  attr_accessor :x, :y # Define accessor methods for our instance variables
end

# ---------------------------

p = Point.new(1,1)
p.x = 0
p.y = 0

# ---------------------------

class Point
  attr_reader :x, :y  # Define reader methods for our instance variables


# ---------------------------

attr_reader "x", "y"

# ---------------------------

attr :x        # Define a trivial getter method x for @x
attr :y, true  # Define getter and setter methods for @y

def each
yield @x
yield @y
end

end

# ---------------------------
# 7.1.6 Defining Operators

class Point
  attr_reader :x, :y   # Define accessor methods for our instance variables

  def initialize(x,y)
    @x,@y = x, y
  end

  def +(other)         # Define + to do vector addition
    Point.new(@x + other.x, @y + other.y)
  end

  def -@               # Define unary minus to negate both coordinates
    Point.new(-@x, -@y)
  end

  def *(scalar)        # Define * to perform scalar multiplication
    Point.new(@x*scalar, @y*scalar)
  end
end

# ---------------------------

# NoMethodError: undefined method `x' for 3:Fixnum
#         from ./point.rb:37:in `+'

# ---------------------------

def +(other)
  raise TypeError, "Point argument expected" unless other.is_a? Point
  Point.new(@x + other.x, @y + other.y)
end

# ---------------------------

def +(other)
  raise TypeError, "Point-like argument expected" unless
    other.respond_to? :x and other.respond_to? :y
  Point.new(@x + other.x, @y + other.y)
end

# ---------------------------

def +(other)         # Assume that other looks like a Point
  Point.new(@x + other.x, @y + other.y)
rescue               # If anything goes wrong above
  raise TypeError,   # Then raise our own exception
    "Point addition with an argument that does not quack like a Point!"
end

# ---------------------------

# If we try passing a Point to the * method of an Integer, it will call
# this method on the Point and then will try to multiply the elements of 
# the array. Instead of doing type conversion, we switch the order of
# the operands, so that we invoke the * method defined above.
def coerce(other)
  [self, other]
end

# ---------------------------
# 7.1.7 Array and Hash Access with [ ]

# Define [] method to allow a Point to look like an array or
# a hash with keys :x and :y
def [](index)
  case index
  when 0, -2 then @x         # Index 0 (or -2) is the X coordinate
  when 1, -1 then @y         # Index 1 (or -1) is the Y coordinate
  when :x, "x" then @x       # Hash keys as symbol or string for X
  when :y, "y" then @y       # Hash keys as symbol or string for Y
  else nil                   # Arrays and hashes just return nil on bad indexes
  end
end

# ---------------------------
# 7.1.8 Enumerating Coordinates

# This iterator passes the X coordinate to the associated block, and then
# passes the Y coordinate, and then returns. It allows us to enumerate
# a point as if it were an array with two elements. This each method is
# required by the Enumerable module.
def each
  yield @x
  yield @y
end

# ---------------------------

p = Point.new(1,2)
p.each {|x| print x }   # Prints "12"

# ---------------------------

include Enumerable

# ---------------------------

# Is the point P at the origin?
p.all? {|x| x == 0 } # True if the block is true for all elements

# ---------------------------
# 7.1.9 Point Equality

def ==(o)               # Is self == o?
  if o.is_a? Point      # If o is a Point object
    @x==o.x && @y==o.y  # then compare the fields.
  elsif                 # If o is not a Point
    false               # then, by definition, self != o.
  end
end

# ---------------------------

def ==(o)                  # Is self == o?
  @x == o.x && @y == o.y   # Assume o has proper x and y methods
rescue                     # If that assumption fails
  false                    # Then self != o
end

# ---------------------------

class Point
  alias eql? ==


# ---------------------------

def eql?(o)             
  if o.instance_of? Point      
    @x.eql?(o.x) && @y.eql?(o.y)
  elsif
    false
  end
end

# ---------------------------

def hash
  @x.hash + @y.hash
end

# ---------------------------

def hash
  code = 17
  code = 37*code + @x.hash
  code = 37*code + @y.hash
  # Add lines like this for each significant instance variable
  code  # Return the resulting code
end
end
# ---------------------------
# 7.1.10 Ordering Points

class Point
include Comparable   # Mix in methods from the Comparable module.

# Define an ordering for points based on their distance from the origin.
# This method is required by the Comparable module.
def <=>(other)
  return nil unless other.instance_of? Point
  @x**2 + @y**2 <=> other.x**2 + other.y**2
end
end
# ---------------------------

p,q = Point.new(1,0), Point.new(0,1)
p == q        # => false: p is not equal to q
p < q         # => false: p is not less than q
p > q         # => false: p is not greater than q

# ---------------------------
# 7.1.11 A Mutable Point
class Point
attr_accessor :x, :y

# ---------------------------

def add!(p)          # Add p to self, return modified self
  @x += p.x
  @y += p.y
  self
end

# ---------------------------

def add(p)           # A nonmutating version of add!
  q = self.dup       # Make a copy of self
  q.add!(p)          # Invoke the mutating method on the copy
end
end
# ---------------------------
# 7.1.12 Quick and Easy Mutable Classes

Struct.new("Point", :x, :y)  # Creates new class Struct::Point
Point = Struct.new(:x, :y)   # Creates new class, assigns to Point

# ---------------------------

C = Class.new   # A new class with no body, assigned to a constant
c = C.new       # Create an instance of the class
c.class.to_s    # => "C": constant name becomes class name

# ---------------------------

p = Point.new(1,2)   # => #<struct Point x=1, y=2>
p.x                  # => 1 
p.y                  # => 2
p.x = 3              # => 3
p.x                  # => 3

# ---------------------------

p[:x] = 4             # => 4: same as p.x =
p[:x]                 # => 4: same as p.x
p[1]                  # => 2: same as p.y
p.each {|c| print c}  # prints "42"
p.each_pair {|n,c| print n,c }   # prints "x4y2"

# ---------------------------

q = Point.new(4,2)
q == p        # => true
h = {q => 1}  # Create a hash using q as a key
h[p]          # => 1: extract value using p as key
q.to_s        # => "#<struct Point x=4, y=2>"

# ---------------------------

Point = Struct.new(:x, :y)   # Create new class, assign to Point
class Point                  # Open Point class for new methods
  def add!(other)            # Define an add! method
    self.x += other.x
    self.y += other.y
    self
  end

  include Comparable         # Include a module for the class
  def <=>(other)             # Define the <=> operator
    return nil unless other.instance_of? Point
    self.x**2 + self.y**2 <=> other.x**2 + other.y**2
  end
end

# ---------------------------

Point = Struct.new(:x, :y)  # Define mutable class
class Point                 # Open the class
  undef x=,y=,[]=           # Undefine mutator methods
end

# ---------------------------
# 7.1.13 A Class Method

class Point

  attr_reader :x, :y     # Define accessor methods for our instance variables

  def Point.sum(*points) # Return the sum of an arbitrary number of points
    x = y = 0
    points.each {|p| x += p.x; y += p.y }
    Point.new(x,y)
  end

  # ...the rest of class omitted here...


# ---------------------------

# total = Point.sum(p1, p2, p3)  # p1, p2 and p3 are Point objects

# ---------------------------

def self.sum(*points)  # Return the sum of an arbitrary number of points
  x = y = 0
  points.each {|p| x += p.x; y += p.y }
  Point.new(x,y)
end
end
# ---------------------------

# Open up the Point object so we can add methods to it
class << Point      # Syntax for adding methods to a single object
  def sum(*points)  # This is the class method Point.sum
    x = y = 0
    points.each {|p| x += p.x; y += p.y }
    Point.new(x,y)
  end

  # Other class methods can be defined here
end

# ---------------------------

class Point
  # Instance methods go here

  class << self
    # Class methods go here
  end
end

# ---------------------------
# 7.1.14 Constants

class Point

  def initialize(x,y)  # Initialize method
    @x,@y = x, y 
  end

  ORIGIN = Point.new(0,0)
  UNIT_X = Point.new(1,0)
  UNIT_Y = Point.new(0,1)

  # Rest of class definition goes here

end

# ---------------------------

# Point::UNIT_X + Point::UNIT_Y   # => (1,1)

# ---------------------------

Point::NEGATIVE_UNIT_X = Point.new(-1,0)

# ---------------------------
# 7.1.15 Class Variables

class Point
  # Initialize our class variables in the class definition itself
  @@n = 0              # How many points have been created
  @@totalX = 0         # The sum of all X coordinates
  @@totalY = 0         # The sum of all Y coordinates

  def initialize(x,y)  # Initialize method
    @x,@y = x, y       # Sets initial values for instance variables

    # Use the class variables in this instance method to collect data
    @@n += 1           # Keep track of how many Points have been created
    @@totalX += x      # Add these coordinates to the totals
    @@totalY += y
  end

  # A class method to report the data we collected
  def self.report
    # Here we use the class variables in a class method
    puts "Number of points created: #@@n"
    puts "Average X coordinate: #{@@totalX.to_f/@@n}"
    puts "Average Y coordinate: #{@@totalY.to_f/@@n}"
  end
end

# ---------------------------
# 7.1.16 Class Instance Variables

class Point
  # Initialize our class instance variables in the class definition itself
  @n = 0              # How many points have been created
  @totalX = 0         # The sum of all X coordinates
  @totalY = 0         # The sum of all Y coordinates

  def initialize(x,y) # Initialize method 
    @x,@y = x, y      # Sets initial values for instance variables
  end

  def self.new(x,y)   # Class method to create new Point objects
    # Use the class instance variables in this class method to collect data
    @n += 1           # Keep track of how many Points have been created
    @totalX += x      # Add these coordinates to the totals
    @totalY += y

    super             # Invoke the real definition of new to create a Point
                      # More about super later in the chapter
  end

  # A class method to report the data we collected
  def self.report
    # Here we use the class instance variables in a class method
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX.to_f/@n}"
    puts "Average Y coordinate: #{@totalY.to_f/@n}"
  end
end

# ---------------------------

class << self
  attr_accessor :n, :totalX, :totalY
end

# ---------------------------
