# ---------------------------
# 7.3 Subclassing and Inheritance

class Point
  def initialize(x,y)
    @x, @y = x, y
  end
end

class Point3Ds < Point    # Define class Point3D as a subclass of Point
end

# ---------------------------

class Point3D < Struct.new("Point3D", :x, :y, :z)
  # Superclass struct gives us accessor methods, ==, to_s, etc.
  # Add point-specific methods here
end

# ---------------------------
# 7.3.1 Inheriting Methods

p2 = Point.new(1,2)
p3 = Point3D.new(1,2)
print p2.to_s, p2.class   # prints "(1,2)Point"
print p3.to_s, p3.class   # prints "(1,2)Point3D"

# ---------------------------
# 7.3.2 Overriding Methods

o = Object.new
puts o.to_s      # Prints something like "#<Object:0xb7f7fce4>"

# ---------------------------

# Greet the World
class WorldGreeter
  def greet                      # Display a greeting
    puts "#{greeting} #{who}"
  end

  def greeting                   # What greeting to use
    "Hello"
  end

  def who                        # Who to greet
    "World"
  end
end

# Greet the world in Spanish
class SpanishWorldGreeter < WorldGreeter
  def greeting                   # Override the greeting
    "Hola"
  end
end

# We call a method defined in WorldGreeter, which calls the overridden
# version of greeting in SpanishWorldGreeter, and prints "Hola World"
SpanishWorldGreeter.new.greet

# ---------------------------

# This class is abstract; it doesn't define greeting or who
# No special syntax is required: any class that invokes methods that are
# intended for a subclass to implement is abstract.
class AbstractGreeter
  def greet
    puts "#{greeting} #{who}"
  end
end

# A concrete subclass
class WorldGreeterv < AbstractGreeter
  def greeting; "Hello"; end
  def who; "World"; end
end

WorldGreeterv.new.greet  # Displays "Hello World"

# ---------------------------
# 7.3.3 Augmenting Behavior by Chaining

class Point3Da < Point
  def initialize(x,y,z)
    # Pass our first two arguments along to the superclass initialize method
    super(x,y)
    # And deal with the third argument ourself
    @z = z;
  end
end

# ---------------------------
# 7.3.5 Inheritance and Instance Variables

class Point3Db < Point
  def initialize(x,y,z)
    super(x,y)
    @z = z;
  end

  def to_s
    "(#@x, #@y, #@z)"  # Variables @x and @y inherited?
  end
end

# ---------------------------

Point3Db.new(1,2,3).to_s  # => "(1, 2, 3)"

# ---------------------------
# 7.3.6 Inheritance and Class Variables

class A
  @@value = 1                   # A class variable
  def A.value; @@value; end     # An accessor method for it
end
print A.value                   # Display value of A's class variable
class B < A; @@value = 2; end   # Subclass alters shared class variable
print A.value                   # Superclass sees altered value
class C < A; @@value = 3; end   # Another alters shared variable again
print B.value                   # 1st subclass sees value from 2nd subclass

# ---------------------------
# 7.3.7 Inheritance of Constants

ORIGIN = Point3D.new(0,0,0)

# ---------------------------