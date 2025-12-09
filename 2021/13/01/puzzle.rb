class Paper
  def initialize(width, height, rows, instructions)
    @width, @height, @rows, @instructions = width, height, rows, instructions
  end

  def fold
    orientation = @instructions.first.first
    line = @instructions.first.last.to_i

    orientation == "y" ? fold_horizontal(line) : fold_vertical(line)
  end

  def mark_count
    @rows.flatten.count("#")
  end

  private

  def fold_horizontal(line)
    bottom = @rows[0...line]
    top = @rows[(line + 1)..].reverse
  
    bottom.each_with_index do |row, ri|
      row.each_with_index do |mark, ci|
        top[ri][ci] = mark if mark == '#'
      end
    end
  
    @rows = top
  end
  
  def fold_vertical(line)
    @rows = @rows.transpose
    @rows = fold_horizontal(line).transpose
  end 
end

# Get input

inputs = File.readlines('../inputs').map { |line| line.chomp.split(',') }

data = inputs[0...inputs.index([])]

instructions = (inputs - data)[1..]
.flatten
.map { |ins| ins.tr('fold along ', '').split('=') }

data.map! { |coords| coords.map(&:to_i) }

width, height = data.map(&:first).max + 1, data.map(&:last).max + 1
rows = []

height.times { rows << ['.'] * width }
data.each { |coords| rows[coords.last][coords.first] = '#' }

# Fold

paper = Paper.new(width, height, rows, instructions)

paper.fold
puts paper.mark_count
