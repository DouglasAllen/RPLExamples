while gets             # Read a line of input into $_
  $F = split if $-a    # Split $_ into fields if -a was specified
  chop! if $-l         # Chop line ending off $_ if -l was specified
  # Program text here
  print                # Output $_ (adding $/ if -l was specified)
end