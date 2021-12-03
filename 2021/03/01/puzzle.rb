inputs = File.readlines('../inputs')
.map { |input| input.chomp.chars.map(&:to_i) }
.transpose

gamma, epsilon = '', ''

inputs.each do |input|
  counts = [0, 1].minmax_by { |x| input.count(x) }
  epsilon << counts.first.to_s
  gamma << counts.last.to_s
end

puts gamma.to_i(2) * epsilon.to_i(2)
