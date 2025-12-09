input = File.readlines('../inputs').map(&:chomp).map { |line| line.split(' ') }

def generate_arrangements(length, constraints, pattern)
  @constraints = constraints
  @pattern = pattern
  @memo = {}

  recursive_arrangements(length, 0, 0, 0, [])
end

def recursive_arrangements(
  length, index, constraint_index, last_block, block_lengths
)
  if (
    index > length ||
    constraint_index > @constraints.length
  )

    return 0
  end

  if (
    index == length &&
    constraint_index == @constraints.length &&
    block_lengths == @constraints
  )

    return 1
  end

  if @memo.key?([index, constraint_index, last_block, block_lengths])
    return @memo[[index, constraint_index, last_block, block_lengths]] 
  end

  count = 0

  if (@pattern[index] != '#' &&
    (constraint_index == 0 ||
      (constraint_index < @constraints.length &&
        last_block < @constraints[constraint_index]
      )
    )
  )
    count += recursive_arrangements(
      length, index + 1,
      constraint_index,
      last_block + 1,
      block_lengths + [last_block + 1]
    )
  end

  if (
    @pattern[index] != '.' &&
    constraint_index < @constraints.length &&
    last_block == @constraints[constraint_index]
  )

    count += recursive_arrangements(
      length,
      index + 1,
      constraint_index + 1,
      0,
      block_lengths + [0]
    )
  end

  @memo[[index, constraint_index, last_block, block_lengths]] = count
  
  count
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

p counts
p counts.sum
