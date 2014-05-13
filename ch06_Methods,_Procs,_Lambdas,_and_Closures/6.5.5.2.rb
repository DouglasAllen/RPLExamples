# 6.5.5.2 Break in blocks, procs and lambdas

def test
  puts "entering test method"
  proc = Proc.new { puts "entering proc"; break }
  proc.call                    # LocalJumpError: iterator has already returned
  puts "exiting test method"
end
#test

# ---------------------------
def iterator(&proc)
  puts "entering iterator"
  proc.call  # invoke the proc
  puts "exiting iterator"   # Never executed if the proc breaks
end

def test
  iterator { puts "entering proc"; break }
end
test

# ---------------------------
def test
  puts "entering test method"
  lambda = lambda { puts "entering lambda"; break; puts "exiting lambda" }
  lambda.call  
  puts "exiting test method"
end
test