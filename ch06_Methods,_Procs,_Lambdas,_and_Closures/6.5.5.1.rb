# 6.5.5.1 Return in blocks, procs, and lambdas

def test
  puts "entering method"
  1.times { puts "entering block"; return }  # Makes test method return
  puts "exiting method"  # This line is never executed
end
test

# ---------------------------
def test
  puts "entering method"
  p = Proc.new { puts "entering proc"; return } 
  p.call                 # Invoking the proc makes method return
  puts "exiting method"  # This line is never executed
end
test

# ---------------------------
def procBuilder(message)            # Create and return a proc
  Proc.new { puts message; return } # return returns from procBuilder
  # but procBuilder has already returned here!
end

def test
  puts "entering method"
  p = procBuilder("entering proc")
  p.call                 # Prints "entering proc" and raises LocalJumpError!
  puts "exiting method"  # This line is never executed
end
# test

# ---------------------------
def test
  puts "entering method"
  p = lambda { puts "entering lambda"; return } 
  p.call                 # Invoking the lambda does not make the method return
  puts "exiting method"  # This line *is* executed now
end
test

# ---------------------------
def lambdaBuilder(message)        # Create and return a lambda
  lambda { puts message; return } # return returns from the lambda
end

def test
  puts "entering method"
  l = lambdaBuilder("entering lambda")
  l.call                 # Prints "entering lambda" 
  puts "exiting method"  # This line is executed
end
test