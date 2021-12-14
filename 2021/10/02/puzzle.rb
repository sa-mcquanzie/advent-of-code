inputs = File.readlines('../inputs').map(&:chomp)
bracket_pairs = /\[\]|\{\}|\(\)|\<\>/
opposite = { '(' => ')', '{' => '}', '[' => ']', '<' => '>' }
points = [')', ']', '}', '>'].zip(4321.digits).to_h
incomplete = []
scores = []

inputs.each do |line|
  line.gsub!(bracket_pairs, '') while line.match bracket_pairs
  incomplete << line unless line.chars.find { |c| [')', ']', '}', '>'].include? c }
end

incomplete.each do |str|
  score = 0

  str.reverse.chars.map { |c| opposite[c] }.each do |char|
    score *= 5
    score += points[char]
  end

  scores << score
end

puts scores.sort[(scores.size / 2).ceil]
