#~ require "continuation"
arr = [ "Freddie", "Herbie", "Ron", "Max", "Ringo" ]

trace = TracePoint.new(:raise) do |tp|
    p [tp.lineno, tp.event, tp.raised_exception]
end
trace.enable
callcc{|cc| 
	$cc = cc
	puts cc
	puts(message = arr.shift)
        $cc.call unless message =~ /Max/
	}
