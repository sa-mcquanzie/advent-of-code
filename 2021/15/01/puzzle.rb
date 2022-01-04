class Location
  attr_accessor :coords, :cost, :neighbours, :previous, :risk

  def initialize(coords, cave_size, risk)
    @coords = coords
    @cost = Float::INFINITY
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
  def initialize(map)
    @locations = []
    @size = map.size

    map.each_with_index do |row, y|
      row.each_with_index do |risk, x|
        @locations << Location.new([x, y], @size, risk)
      end
    end
  end

  def location(x, y)
    @locations.find { |l| l.coords == [x, y] }
  end

  def neighbours(coords)
    @locations.select { |l| location(coords).neighbours.include?(l.coords) }
  end

  def safest_path_risk
    start = location(0, 0)
    unvisited = @locations.dup
    visited = []
    start.cost = 0

    until unvisited.empty?
      current_location = unvisited.min_by(&:cost)

      visited << current_location
      unvisited.delete(current_location)

      current_location.neighbours.each do |coords|
        x, y = coords
        neighbour = location(x, y)

        next if visited.include?(neighbour)

        new_cost = current_location.cost + neighbour.risk

        if new_cost < neighbour.cost
          neighbour.cost = new_cost
          neighbour.previous = current_location
        end
      end
    end

    location(@size - 1, @size - 1).cost
  end
end

map = File.readlines('../inputs').map(&:chomp).map { |line| line.chars.map(&:to_i) }

puts "Risk of safest path is #{Cave.new(map).safest_path_risk}"
