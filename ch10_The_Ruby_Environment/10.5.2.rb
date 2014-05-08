$SAFE=1                # upgrade the safe level
$SAFE=4                # upgrade the safe level even higher
$SAFE=0                # SecurityError!  you can't do it
---------------------------
Thread.start {     # Create a "sandbox" thread
  $SAFE = 4        # Restrict execution in this thread only
  ...              # Untrusted code can be run here
}