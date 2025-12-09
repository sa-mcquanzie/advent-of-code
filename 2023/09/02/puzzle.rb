def pyramid(array, length = nil)
  length ||= array.length

  return [array] if array.all?(&:zero?)

  [array] + (pyramid(array.map.with_index do |val, idx|
    idx == 0 ? val : val - array[idx - 1]
  end[1..-1], length - 1))
end

p File.readlines('../inputs')
  .map(&:chomp)
  .map { |line| line.split(' ').map(&:to_i) }
  .map { |arr| pyramid(arr) }
  .map { |arr| arr.reverse.map(&:first).reduce(0) { |sum, num| sum = num - sum } }
  .sum
