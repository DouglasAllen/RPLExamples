a = [3, 2, 1]     # This is an array literal
a[3] = a[2] - 1   # Use square brackets to query and set array elements
a.each do |elt|   # each is an iterator. The block has a parameter elt
  print elt+1     # Prints "4321"
end               # This block was delimited with do/end instead of {}