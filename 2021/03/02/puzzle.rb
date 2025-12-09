def rate(rate_type, inputs)
  rate = []

  inputs.transpose.each do |input|
    minmax = [0, 1].minmax_by { |x| input.count(x) }
    rate_index = rate_type == :epsilon ? minmax.first : minmax.last
    dividend = rate_type == :epsilon ? 2 : 3
    rate << (minmax.first == minmax.last ? dividend : rate_index)
  end

  rate.map! { |digit| digit % 2 }
end

def find_rating(rate_type, inputs, index = 0)
  return inputs.flatten.map(&:to_s).join.to_i(2) if inputs.size == 1

  digit = rate(rate_type, inputs)[index]
  new_inputs = inputs.select { |digits| digits[index] == digit }
  index += 1

  find_rating(rate_type, new_inputs, index)
end

def life_support_rating(ratings)
  ratings.inject(&:*)
end

data = File.readlines('../inputs').map { |number| number.chomp.chars.map(&:to_i) }
oxygen_generator_rating = find_rating(:epsilon, data)
co2_scrubber_rating = find_rating(:gamma, data)

puts life_support_rating([oxygen_generator_rating, co2_scrubber_rating])
