# ---------------------------
# 7.8 Method Lookup

message = "hello"
# message.world

# ---------------------------

# undefined method `world' for "hello":String (NoMethodError)

# ---------------------------
# 7.8.1 Class Method Lookup

class C
end

# ---------------------------

c = C.new

# ---------------------------

def Integer.parse(text)
  text.to_i
end

# ---------------------------

n = Fixnum.parse("1")

# ---------------------------