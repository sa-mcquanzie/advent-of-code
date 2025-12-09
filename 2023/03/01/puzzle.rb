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
  attr_reader :part_number_sum

  def initialize schematic
    @checked_cells = []
    new_cells = make_cells(schematic)
    @cells = add_neighbours(new_cells)
    @part_number_sum = find_part_number_sum(@cells)
  end

  def is_symbol?(val) = val =~ /[^a-zA-Z0-9\.]/
  def is_number?(val) = val =~ /[0-9]/

  def make_cells schematic
    schematic.map.with_index do |row, y|
      row.chars.map.with_index do |val, x|
        Cell.new x, y, val
      end
    end
  end

  def add_neighbours cells
    neighbours = []
    cells.each do |row|
      row.each do |cell|
        cell_n = [
          cell.x, cell.y - 1, cells[cell.y - 1][cell.x].value
        ] if cell.y > 0
        cell_ne = [
          cell.x + 1, cell.y - 1, cells[cell.y - 1][cell.x + 1].value
        ] if cell.y > 0 && cell.x < cells[cell.y].length - 1
        cell_e = [
          cell.x + 1, cell.y, cells[cell.y][cell.x + 1].value
        ] if cell.x < cells[cell.y].length - 1
        cell_se = [
          cell.x + 1, cell.y + 1, cells[cell.y + 1][cell.x + 1].value
        ] if cell.y < cells.length - 1 && cell.x < cells[cell.y].length - 1
        cell_s = [
          cell.x, cell.y + 1, cells[cell.y + 1][cell.x].value
        ] if cell.y < cells.length - 1
        cell_sw = [
          cell.x - 1, cell.y + 1, cells[cell.y + 1][cell.x - 1].value
        ] if cell.y < cells.length - 1 && cell.x > 0
        cell_w = [
          cell.x - 1, cell.y, cells[cell.y][cell.x - 1].value
        ] if cell.x > 0
        cell_nw = [
          cell.x - 1, cell.y - 1, cells[cell.y - 1][cell.x - 1].value
        ] if cell.y > 0 && cell.x > 0

        cell.neighbours.push Neighbour.new(*cell_n) if cell_n
        cell.neighbours.push Neighbour.new(*cell_ne) if cell_ne
        cell.neighbours.push Neighbour.new(*cell_e) if cell_e
        cell.neighbours.push Neighbour.new(*cell_se) if cell_se
        cell.neighbours.push Neighbour.new(*cell_s) if cell_s
        cell.neighbours.push Neighbour.new(*cell_sw) if cell_sw 
        cell.neighbours.push Neighbour.new(*cell_w) if cell_w
        cell.neighbours.push Neighbour.new(*cell_nw) if cell_nw 
      end
    end
  end

  def number_adjacent_to_symbol? cell
    is_number?(cell.value) &&
    !is_symbol?(cell.value) &&
    cell.neighbours.any? { |neighbour| is_symbol?(neighbour.value) }
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

  def find_part_number_sum cells
    part_numbers = []

    cells.flatten.each do |cell|
      next if is_symbol?(cell.value)
      next if !number_adjacent_to_symbol?(cell)

      start_cell = find_start_cell(cells, cell)

      next if @checked_cells.include?(start_cell)
      
      @checked_cells << start_cell
      part_numbers << build_full_number(cells, start_cell, start_cell.value)
    end

    part_numbers.compact.map(&:to_i).sum
  end
end

schematic = File.readlines('../inputs').map(&:chomp)
engine = Engine.new(schematic)

p engine.part_number_sum
