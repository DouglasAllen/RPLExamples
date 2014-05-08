os = `uname`             # String literal and method invocation in one
os = %x{uname}           # Another quoting syntax
os = Kernel.`("uname")   # Invoke the method explicitly

---------------------------
files = `echo *.xml`

---------------------------
pipe = open("|echo *.xml")
files = pipe.readline
pipe.close