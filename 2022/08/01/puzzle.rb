forest = File.readlines('../inputs').map(&:chomp).map { |row| row.chars.map(&:to_i) }

visibility_map = forest.map.with_index do |row, row_index|
  row.map.with_index do |tree_height, col_index|
    unless col_index.zero? || col_index == row.length - 1
      rotated_forest = forest.reverse.transpose

      (north, east, south, west) = [
        rotated_forest[col_index][(row.length - (row_index + 1)) + 1..-1],
        forest[row_index][col_index + 1..-1],
        rotated_forest[col_index][0...(row.length - (row_index + 1))],
        forest[row_index][0...col_index]
      ].map { |direction| direction.none? { |tree| tree >= tree_height }}
    
      north || east || south || west
    else
      true
    end
  end
end

p visibility_map.flatten.count true
