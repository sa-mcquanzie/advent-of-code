p File.readlines('../inputs')
  .map { |pair| pair.chomp.split(',')
    .map { |nums|
      nums.split('-').map(&:to_i)
    }
  }.map { |((a, b), (c, d))| 
    (a >= c && b <= d) || (c >= a && d <= b)
}.count(true)
