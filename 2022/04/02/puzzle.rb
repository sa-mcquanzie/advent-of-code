p File.readlines('../inputs')
  .map { |pair| pair.chomp.split(',')
    .map { |nums|
      nums.split('-').map(&:to_i)
    }
  }.map { |((a, b), (c, d))| 
    (a >= c && a <= d ) || (c >= a && c <= b)
}.count(true)
