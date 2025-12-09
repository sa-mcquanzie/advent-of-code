crabs = File.read('../inputs').chomp.split(',').map(&:to_i)

winning_sum = Float::INFINITY

(crabs.min..crabs.max).each do |num|
  sum = 0

  crabs.each do |crab|
    n = (num - crab).abs
    sum += (n * (n + 1)) / 2
  end

  winning_sum = sum if sum < winning_sum
end

puts winning_sum
