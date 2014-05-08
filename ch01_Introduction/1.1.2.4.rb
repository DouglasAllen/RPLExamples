h = {                         # A hash that maps number names to digits
  :one => 1,                  # The "arrows" show mappings: key=>value
  :two => 2                   # The colons indicate Symbol literals
}  
h[:one]                       # => 1.  Access a value by key
h[:three] = 3                 # Add a new key/value pair to the hash
h.each do |key,value|         # Iterate through the key/value pairs
  print "#{value}:#{key}; "   # Note variables substituted into string 
end                           # Prints "1:one; 2:two; 3:three; "