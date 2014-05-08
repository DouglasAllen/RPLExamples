fork {
  puts "Hello from the child process: #$$"
}
puts "Hello from the parent process: #$$"
---------------------------
pid = fork
if (pid)
  puts "Hello from parent process: #$$"
  puts "Created child process #{pid}"   
else
  puts Hello from child process: #$$"
end
---------------------------
open("|-", "r+") do |child|
  if child
    # This is the parent process
    child.puts("Hello child")       # Send to child
    response = child.gets           # Read from child
    puts "Child said: #{response}"
  else
    # This is the child process
    from_parent = gets              # Read from parent
    STDERR.puts "Parent said: #{from_parent}"
    puts("Hi Mom!")                 # Send to parent
  end
end
---------------------------
open("|-", "r") do |child|
  if child
    # This is the parent process
    files = child.readlines   # Read the output of our child
    child.close
  else
    # This is the child process
    exec("/bin/ls", "-l")     # Run another executable
  end
end