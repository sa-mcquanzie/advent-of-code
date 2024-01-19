platform = File.readlines('../inputs').map(&:chomp).map(&:chars)

def fully_tilted? direction, platform
  condition = case direction
  when :north
    ->(y, x) { y > 0 && platform[y - 1][x] == '.' }
  when :south
    ->(y, x) { y < platform.size - 1 && platform[y + 1][x] == '.' }
  when :east
    ->(y, x) { x < platform[y].size - 1 && platform[y][x + 1] == '.' }
  when :west
    ->(y, x) { x > 0 && platform[y][x - 1] == '.' }
  end

  platform.each.with_index do |row, y|
    row.each.with_index do |col, x|
      if col == 'O'
        return false if condition.call(y, x)
      end
    end
  end

  true
end

def roll_rock direction, platform, y, x
  (condition, action) = case direction
  when :north
    [->(y, x) { y > 0 && platform[y - 1][x] == '.' },
     ->(y, x) { platform[y - 1][x] = platform[y][x]; platform[y][x] = '.' }]
  when :south
    [->(y, x) { y < platform.size - 1 && platform[y + 1][x] == '.' },
     ->(y, x) { platform[y + 1][x] = platform[y][x]; platform[y][x] = '.' }]
  when :east
    [->(y, x) { x < platform[y].size - 1 && platform[y][x + 1] == '.' },
     ->(y, x) { platform[y][x + 1] = platform[y][x]; platform[y][x] = '.' }]
  when :west
    [->(y, x) { x > 0 && platform[y][x - 1] == '.' },
     ->(y, x) { platform[y][x - 1] = platform[y][x]; platform[y][x] = '.' }]
  end

  action.call(y, x) if condition.call(y, x)

  platform
end

def roll_recursive direction, platform
  platform.each.with_index do |row, y|
    row.each.with_index do |col, x|
      if col == 'O'
        roll_rock(direction, platform, y, x)
      end
    end
  end

  if !fully_tilted?(direction, platform)
    roll_recursive(direction, platform)
  else
    platform
  end
end

def roll_cycle platform, seen_states
  last_platform = platform.dup
  platform = roll_recursive(:north, platform)
  platform = roll_recursive(:west, platform)
  platform = roll_recursive(:south, platform)
  platform = roll_recursive(:east, platform)

  platform_string = platform.map(&:join).join("\n")
  if seen_states[platform_string]
    return last_platform, seen_states.size - seen_states[platform_string]
  else
    seen_states[platform_string] = seen_states.size
    return platform, nil
  end
end

seen_states = {}
cycle_start = nil
cycle_length = nil

1000000000.times do |i|
  platform, cycle_length = roll_cycle(platform, seen_states)
  if cycle_length
    cycle_start = i - cycle_length + 1
    break
  end
end

if cycle_length
  remaining_cycles = (1000000000 - cycle_start) % cycle_length
  remaining_cycles.times do
    platform, _ = roll_cycle(platform, seen_states)
  end
end

if platform
  platform.each { |row| puts row.join }

  puts platform.each.with_index.inject(0) { |sum1, (row, y)|
    sum1 + row.each.with_index.inject(0) { |sum2, (col, x)|
      col == 'O' ? sum2 + platform.size - y : sum2
    }
  }
end
