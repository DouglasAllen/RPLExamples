ruby -e 'puts Module.constants.sort.reject{|x| eval(x.to_s).is_a? Module}'