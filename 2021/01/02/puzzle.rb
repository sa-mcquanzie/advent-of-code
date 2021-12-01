inputs = File.readlines('../inputs').map(&:chomp).map(&:to_i).each_cons(3).to_a
puts inputs
  .flat_map
  .with_index { |arr, ind| true if ind.positive? && (arr.sum > inputs[ind - 1].sum) }
  .count(true)
