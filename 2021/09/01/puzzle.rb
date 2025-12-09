grid = File.readlines('../inputs').map(&:chomp).map(&:chars).map { |a| a.map(&:to_i)}
GRID_SIZE = grid.first.size

class Cell
  attr_reader :x, :y, :h, :neighbours

  def initialize(x, y, h)
    @x, @y, @h = x, y, h
    @neighbours = [
      y > 0 ? [x, y - 1] : nil,
      x < GRID_SIZE - 1 ? [x + 1, y] : nil,
      y < GRID_SIZE - 1 ? [x, y + 1] : nil,
      x > 0 ? [x - 1, y] : nil
    ]
  end
end

cells = {}
risks = 0

grid.each.with_index { |row, y| row.each.with_index { |h, x| cells[[x, y]] = Cell.new(x, y, h) } }

cells.values.each do |cell| 
  neighbours = cell.neighbours.map { |c| cells[c] }.compact
  risks += cell.h + 1 if neighbours.all? { |c| c.h > cell.h }
end

p risks
