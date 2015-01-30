# ---------------------------
# 7.2 Method Visibility: Public, Protected, Private

class Point
  # public methods go here

  # The following methods are protected
  protected

  # protected methods go here

  # The following methods are private
  private

  # private methods go here
end

# ---------------------------

class Widget
  def x                       # Accessor method for @x
    @x
  end
  protected :x                # Make it protected

  def utility_method          # Define a method
    nil
  end
  private :utility_method     # And make it private
end

# ---------------------------

# private_class_method :new

# ---------------------------

w = Widget.new                      # Create a Widget
w.send :utility_method              # Invoke private method!
w.instance_eval { utility_method }  # Another way to invoke it
w.instance_eval { @x }              # Read instance variable of w

# ---------------------------