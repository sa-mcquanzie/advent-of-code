inputs = File.readlines('../inputs').map(&:chomp)
bracket_pairs = /\[\]|\{\}|\(\)|\<\>/
points = [nil, ')', ']', '}', '>'].zip([0, 3, 57, 1197, 25137]).to_h
score = 0

inputs.each do |line|
  line.gsub!(bracket_pairs, '') while line.match bracket_pairs
  score += points[line.chars.find { |char| [')', ']', '}', '>'].include? char }]
end

puts score
