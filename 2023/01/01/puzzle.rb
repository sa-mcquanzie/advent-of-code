inputs = File.readlines('../inputs').map(&:chomp)

calibration_values = inputs.map do |line|
  digits = line.chars.select { |char| Float(char) != nil rescue false }
  [digits[0], digits[-1]].join.to_i
end

puts calibration_values.sum
