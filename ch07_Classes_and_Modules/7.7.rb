# ---------------------------
# 7.7 Singleton Methods and the Eigenclass
class Point
 def Point.sum
  # Method body goes here
 end
end

# ---------------------------

class << Point
  def class_method1      # This is an instance method of the eigenclass.
  end                    # It is also a class method of Point.

  def class_method2
  end
end

# ---------------------------

class Point
  # instance methods go here

  class << self
    # class methods go here as instance methods of the eigenclass
  end
end

# ---------------------------

class Point;end            # Create or open the class Point

class Point3D < Point  # Create a subclass of Point
end

class << Point         # Open the eigenclass of the object Point
end

# ---------------------------

eigenclass = class << Object; self; end

# ---------------------------

class Object
  def eigenclass
    class << self; self; end
  end
end

# ---------------------------
