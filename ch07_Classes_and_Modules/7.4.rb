# ---------------------------
# 7.4.1 new, allocate, and initialize

def new(*args)
  o = self.allocate   # Create a new object of this class
  o.initialize(*args) # Call the object's initialize method with our args
  o                   # Return new object; ignore return value of initialize
end

# ---------------------------
# 7.4.2 Factory Methods

class Point
  # Initialize a Point with two or three coordinates
  def initialize(x, y, z=nil)
    @x,@y,@z = x, y, z
  end
end

# ---------------------------

class Point
  # Define an initialize method as usual...
  def initialize(x,y)  # Expects Cartesian coordinates
    @x,@y = x,y
  end

  # But make the factory method new private
  private_class_method :new

  def Point.cartesian(x,y)  # Factory method for Cartesian coordinates
    new(x,y)  # We can still call new from other class methods
  end

  def Point.polar(r, theta) # Factory method for polar coordinates
    new(r*Math.cos(theta), r*Math.sin(theta))
  end
end

# ---------------------------
# 7.4.3 dup, clone, and initialize_copy

class Point                 # A point in n-space
  def initialize(*coords)   # Accept an arbitrary # of coordinates
    @coords = coords        # Store the coordinates in an array
  end

  def initialize_copy(orig) # If someone copies this Point object
    @coords = @coords.dup   # Make a copy of the coordinates array, too
  end
end

# ---------------------------

class Season
  NAMES = %w{ Spring Summer Autumn Winter }  # Array of season names
  INSTANCES = []                             # Array of Season objects

  def initialize(n)  # The state of a season is just its 
    @n = n           # index in the NAMES and INSTANCES arrays
  end

  def to_s           # Return the name of a season 
    NAMES[@n]
  end

  # This code creates instances of this class to represent the seasons 
  # and defines constants to refer to those instances.
  # Note that we must do this after initialize is defined.
  NAMES.each_with_index do |name,index|
    instance = new(index)         # Create a new instance
    INSTANCES[index] = instance   # Save it in an array of instances
    const_set name, instance      # Define a constant to refer to it
  end

  # Now that we have created all the instances we'll ever need, we must
  # prevent any other instances from being created
  private_class_method :new,:allocate  # Make the factory methods private
  private :dup, :clone                 # Make copying methods private
end

# ---------------------------
# 7.4.4 marshal_dump and marshal_load

class Point                  # A point in n-space
  def initialize(*coords)    # Accept an arbitrary # of coordinates
    @coords = coords         # Store the coordinates in an array
  end

  def marshal_dump           # Pack coords into a string and marshal that
    @coords.pack("w*")
  end

  def marshal_load(s)        # Unpack coords from unmarshaled string
    @coords = s.unpack("w*") # and use them to initialize the object
  end
end

# ---------------------------

class Season
  # We want to allow Season objects to be marshaled, but we don't
  # want new instances to be created when they are unmarshaled.
  def _dump(limit)         # Custom marshaling method
    @n.to_s                # Return index as a string
  end

  def self._load(s)        # Custom unmarshaling method
    INSTANCES[Integer(s)]  # Return an existing instance
  end
end

# ---------------------------
# 7.4.5 The Singleton Pattern

require 'singleton'           # Singleton module is not built-in

class PointStats              # Define a class
  include Singleton           # Make it a singleton

  def initialize              # A normal initialization method
    @n, @totalX, @totalY = 0, 0.0, 0.0
  end

  def record(point)           # Record a new point
    @n += 1
    @totalX += point.x
    @totalY += point.y
  end

  def report                  # Report point statistics
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX/@n}"
    puts "Average Y coordinate: #{@totalY/@n}"
  end
end

# ---------------------------

def initialize(x,y)
  @x,@y = x,y
  PointStats.instance.record(self)
end

# ---------------------------

PointStats.instance.report

# ---------------------------