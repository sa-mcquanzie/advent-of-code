input = File.readlines('../inputs').map(&:chomp).map { |line| line.split(' ') }

def generate_arrangements(
  length,
  constraints,
  pattern,
  current_string='',
  characters=['.', '#']
)
  if length == 0
    if (
      meets_constraints(current_string, constraints) &&
      matches_pattern(current_string, pattern)
    )
      return 1
    else
      return 0
    end
  else
    pattern_char = length <= pattern.length ? pattern[length - 1] : '?'
    possible_chars = pattern_char == '?' ? characters : [pattern_char]
    count = 0

    possible_chars.each do |char|
      count += generate_arrangements(
        length - 1,
        constraints,
        pattern,
        char + current_string,
        characters
      )
    end
    
    return count
  end
end

def meets_constraints(string, constraints)
  blocks = string.split('.')
  blocks.delete('')
  block_lengths = blocks.map { |block| block.length }
  constraints == block_lengths
end

def matches_pattern(string, pattern)
  string.chars.each_with_index.all? do |char, index|
    pattern_char = pattern[index]
    pattern_char == '?' || pattern_char == char
  end
end

counts = []

input.each do |line|
  data = line.first
  matches = line.last.split(',').map(&:to_i)
  count = generate_arrangements(data.length, matches, data)
  counts << count
end

p counts.sum
