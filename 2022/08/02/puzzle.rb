forest = File.readlines('../inputs').map(&:chomp).map { |row| row.chars.map(&:to_i) }

scenicness_map = forest.map.with_index do |row, row_index|
  row.map.with_index do |tree_height, col_index|
      rotated_forest = forest.reverse.transpose

      (north, east, south, west) = [
        rotated_forest[col_index][(row.length - (row_index + 1)) + 1..-1],
        forest[row_index][col_index + 1..-1],
        rotated_forest[col_index][0...(row.length - (row_index + 1))].reverse,
        forest[row_index][0...col_index].reverse
      ]
    
      [north, east, south, west].map { |view|
        view[0..view.index { |tree| tree >= tree_height }].length
      }.inject(&:*)
  end
end

p scenicness_map.flatten.max
