class Cell
  attr_reader :x, :y, :value
  attr_accessor :neighbours

  def initialize x, y, value
    @x = x
    @y = y
    @value = value
    @neighbours = []
  end
end


class Neighbour
  attr_reader :x, :y, :value

  def initialize x, y, value
    @x = x
    @y = y
    @value = value
  end
end


class Engine
  attr_reader :gear_ratio_sum

  def initialize schematic
    new_cells = make_cells(schematic)
    @cells = add_neighbours(new_cells)
    @gear_ratio_sum = find_gear_ratio_sum(@cells)
  end

  def is_number?(val) = !!(val =~ /[0-9]/)
  def is_gear_symbol?(val) = !!(val =~ /[\*]/)

  def make_cells schematic
    schematic.map.with_index do |row, y|
      row.chars.map.with_index do |val, x|
        Cell.new x, y, val
      end
    end
  end

  # I got Copilot to refactor this method for the 2nd challenge
  # and it's amazing. Thanks Copilot <3
  def add_neighbours cells
    deltas = [
      [-1, -1], [0, -1], [1, -1],
      [-1, 0],           [1, 0],
      [-1, 1],  [0, 1],  [1, 1]
    ]

    cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        deltas.each do |dx, dy|
          nx, ny = x + dx, y + dy
          next unless (0...cells[y].length).include?(nx) && (0...cells.length).include?(ny)

          neighbour = cells[ny][nx]
          cell.neighbours << Neighbour.new(nx, ny, neighbour.value)
        end
      end
    end
  end

  def number_adjacent_to_gear? cell
    is_number?(cell.value) &&
    !is_symbol?(cell.value) &&
    cell.neighbours.any? { |neighbour| is_gear_symbol?(neighbour.value) }
  end

  def find_start_cell cells, cell
    if cell.x > 0
      prev_cell = cells[cell.y][cell.x - 1]

      if is_number?(prev_cell.value)
        find_start_cell(cells, prev_cell)
      else
        cell
      end
    else
      cell
    end
  end

  def build_full_number cells, cell, string
    if cell.x < cells[cell.y].length - 1
      next_cell = cells[cell.y][cell.x + 1]

      if is_number?(next_cell.value)
        string += next_cell.value
        build_full_number(cells, next_cell, string)
      else
        string
      end
    else
      string
    end
  end

  def is_gear? cell
    return false if !is_gear_symbol?(cell.value)

    adjoining_parts = get_adjoining_parts(cell)

    adjoining_parts.uniq.length == 2
  end

  def get_adjoining_parts gear
    parts = []
    
    gear.neighbours.each do |neighbour|
      if is_number?(neighbour.value)
        parts << find_start_cell(@cells, @cells[neighbour.y][neighbour.x])
      end
    end

    parts
  end

  def find_gear_ratio_sum cells
    part_numbers = []

    cells.flatten.each do |cell|
      next if !is_gear_symbol?(cell.value)

      if is_gear?(cell)
        part_numbers << get_adjoining_parts(cell).map do |part|
          build_full_number(cells, part, part.value)
        end.uniq.flat_map(&:to_i)
      end
    end

    part_numbers.map { |part| part.inject(:*)}.sum
  end
end

schematic = File.readlines('../inputs').map(&:chomp)
engine = Engine.new(schematic)

p engine.gear_ratio_sum
