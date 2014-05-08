def safe_eval(str)
  Thread.start {            # Start sandbox thread
    $SAFE = 4               # Upgrade safe level
    eval(str)               # Eval in the sandbox
  }.value                   # Retrieve result
end