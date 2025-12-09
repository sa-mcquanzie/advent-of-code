# This is not my finished solution on account of taking *literally a day* to compute the answer

class Tile
  attr_accessor :coords, :cost, :f_score, :g_score, :h_score, :neighbours, :previous, :risk

  def initialize(coords, cave_size, risk)
    @coords = coords
    @cost = Float::INFINITY
    @f_score = Float::INFINITY
    @g_score = Float::INFINITY
    @h_score = nil
    @risk = risk
    @previous = nil

    x, y = coords

    @neighbours = [
      y.positive? ? [x, y - 1] : nil,
      x < cave_size - 1 ? [x + 1, y] : nil,
      y < cave_size - 1 ? [x, y + 1] : nil,
      x.positive? ? [x - 1, y] : nil
    ].compact
  end
end

class Cave
  attr_accessor :tiles, :exit

  def initialize(grid)
    @tiles = []

    grid.tiles.each_with_index do |row, y|
      row.each_with_index do |risk, x|
        @tiles << Tile.new([x, y], grid.tiles.size, risk)
      end
    end

    @entrance = tile_at(0, 0)
    @exit = tile_at(grid.tiles.size - 1, grid.tiles.size - 1)

    @tiles.each do |tile|
      x1, y1 = tile.coords
      x2, y2 = @exit.coords
      tile.h_score = Math.sqrt(((x2 - x1)**2) + ((y2 - y1)**2))
    end
  end

  def tile_at(x, y)
    @tiles.find { |tile| tile.coords == [x, y] }
  end

  def neighbours(coords)
    @tiles.select { |tile| tile_at(coords).neighbours.include?(tile.coords) }
  end

  def safest_path_risk
    unvisited = @tiles.dup
    visited = []
    @entrance.cost = 0
    @entrance.g_score = 0
    @entrance.f_score = @entrance.h_score
    complete = false

    until complete
      current_tile = unvisited.min_by(&:f_score)

      if current_tile == @exit
        complete = true
        visited << current_tile
        return
      end

      current_tile.neighbours.each do |coords|
        x, y = coords
        neighbour = tile_at(x, y)

        next if visited.include?(neighbour)

        new_g_score = current_tile.g_score + neighbour.risk
        new_cost = current_tile.cost + neighbour.risk

        next unless new_g_score < neighbour.g_score

        neighbour.cost = new_cost
        neighbour.g_score = new_g_score
        neighbour.f_score = new_g_score + neighbour.h_score
        neighbour.previous = current_tile
      end

      visited << current_tile
      unvisited.delete(current_tile)
    end

    @exit.cost
  end
end

class Grid
  attr_accessor :tiles

  def initialize(data)
    @original = data.map(&:chomp).map { |line| line.chars.map(&:to_i) }
    @tiles = expanded
  end

  private

  def expanded
    vertically_expanded = []
    vertically_expanded << [*@original]

    4.times do |i|
      vertically_expanded << @original.map { |arr| arr.map { |level| adjust_risk(level, i) } }
    end

    vertically_expanded.flatten!(1)
    horizontally_expanded = []

    vertically_expanded.each do |row|
      new_row = []
      new_row << row

      4.times do |i|
        new_row << row.map { |level| adjust_risk(level, i) }
      end

      horizontally_expanded << new_row
    end

    horizontally_expanded.map(&:flatten)
  end

  def adjust_risk(risk_level, multiplier)
    new_level = (risk_level + multiplier) % 9 + 1
    new_level.positive? ? new_level : 1
  end
end

inputs = File.readlines('../inputs')
grid = Grid.new(inputs)
cave = Cave.new(grid)

# puts "Risk of safest path is #{cave.safest_path_risk}"

cave.safest_path_risk
p cave.exit.cost
