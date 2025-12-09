data = File.readlines('../inputs').map { |line| line.chomp.split(' | ').map(&:split) }

digit_sizes = [2,3,4,7]
digits = [1,7,4,8]
digits_of_size = digit_sizes.zip(digits).to_h
digit_counts = digits.zip([0] * 4).to_h

data.each do |input, output|
  output.each do |digit|
    next unless digit_sizes.include? digit.size
    occurances = input.count { |d| d.size == digit.size }
    digit_counts[digits_of_size[digit.size]] += occurances
  end
end

puts digit_counts.values.sum
