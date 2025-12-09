grid = File.readlines('../inputs').map(&:chomp).map(&:chars).map { |a| a.map(&:to_i)}
GRID_SIZE = grid.first.size

class Cell
  attr_reader :x, :y, :h, :neighbours, :ridge
  attr_accessor :visited, :basin

  def initialize(x, y, h)
    @x, @y, @h = x, y, h
    @ridge = h == 9
    @basin = nil
    @visited = false
    @neighbours = [
      y > 0 ? [x, y - 1] : nil,
      x < GRID_SIZE - 1 ? [x + 1, y] : nil,
      y < GRID_SIZE - 1 ? [x, y + 1] : nil,
      x > 0 ? [x - 1, y] : nil
  ].compact
  end
end

def find_neighbours(cell, hash)
  cell.neighbours.map { |c| hash[c] }.compact
end

def boundary_fill(cell, hash, basin)
  neighbours = find_neighbours(cell, hash).reject { |neighbour| neighbour.visited || neighbour.ridge }
  return if neighbours.empty?

  neighbours.each do |neighbour|
    neighbour.basin = basin
    neighbour.visited = true
    boundary_fill(neighbour, hash, basin)
  end
end

cells = {}
lows = []
basin_sizes = []

grid.each.with_index { |row, y| row.each.with_index { |h, x| cells[[x, y]] = Cell.new(x, y, h) } }

cells.values.each do |cell| 
  neighbours = find_neighbours(cell, cells)
  lows << [cell.x, cell.y] if neighbours.all? { |c| c.h > cell.h }
end

lows.each.with_index do |coords, ind|
  cells[coords].basin = ind

  boundary_fill(cells[coords], cells, ind)
  
  basin_sizes << cells.values.count { |cell| cell.basin == ind }
  cells.values.each { |cell| cell.visited = false }
end

puts basin_sizes.max(3).inject(&:*)
