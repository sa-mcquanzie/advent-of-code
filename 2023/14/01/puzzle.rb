platform = File.readlines('../inputs').map(&:chomp).map(&:chars)

# platform.each { |row| puts row.join }
# puts

def fully_tilted? platform
  platform.each.with_index do |row, y|
    row.each.with_index do |col, x|
      if col == 'O'
        return false if y > 0 && platform[y - 1][x] == '.'
      end
    end
  end

  true
end

def roll_rock platform, y, x
  if y > 0 && platform[y - 1][x] == '.'
    platform[y - 1][x] = platform[y][x]
    platform[y][x] = '.'
  end

  platform
end

def roll_recursive platform
  platform.each.with_index do |row, y|
    row.each.with_index do |col, x|
      if col == 'O'
        roll_rock(platform, y, x)
      end
    end
  end

  if !fully_tilted? platform
    roll_recursive(platform)
  else
    platform
  end
end

platform = roll_recursive platform

# platform.each { |row| puts row.join }

puts platform.each.with_index.inject(0) { |sum1, (row, y)|
  sum1 + row.each.with_index.inject(0) { |sum2, (col, x)|
    col == 'O' ? sum2 + platform.size - y : sum2
  }
}
