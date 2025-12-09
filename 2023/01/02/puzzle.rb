inputs = File.readlines('../inputs').map(&:chomp)

numbers = (1..9).to_a
english = %w[one two three four five six seven eight nine]
english_to_numbers = Hash[english.zip(numbers)]
regex = /(?=(\d{1})|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine))/

result = inputs.map do |line|
  digits = line.scan(regex)
    .flatten
    .reject(&:nil?)
    .map { |str| english.include? str ? english_to_numbers[str] : str.to_i }

  [digits.first, digits.last].join.to_i
end.sum

p result
