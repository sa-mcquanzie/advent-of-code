puts File.readlines('../inputs').map { |x| x.chomp.to_i }.each_cons(2).to_a.count { |e| e[0] < e[1] }
