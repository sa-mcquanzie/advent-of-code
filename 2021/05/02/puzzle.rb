inputs = File
         .readlines('../inputs')
         .map { |line| line.chomp.split(' -> ').map { |pair| pair.split(',').map(&:to_i) } }
         .map!(&:transpose)

straight_lines = inputs
                 .reject { |coords| coords[0][0] != coords[0][1] && coords[1][0] != coords[1][1] }
                 .map! { |coords| coords.map(&:sort) }

diagonals = inputs.select { |coords| coords[0][0] != coords[0][1] && coords[1][0] != coords[1][1] }

vents = Hash.new(0)

straight_lines.each do |coords|
  x_coords = coords[0][0]..coords[0][-1]
  y_coords = coords[1][0]..coords[1][-1]

  x_coords.each { |x| y_coords.each { |y| vents[[x, y]] += 1 } }
end

diagonals.each do |coords|
  x_coords =
    if coords[0][0] < coords[0][1]
      (coords[0][0]..coords[0][-1]).to_a
    else
      coords[0][0].downto(coords[0][-1]).to_a
    end

  y_coords =
    if coords[1][0] < coords[1][1]
      (coords[1][0]..coords[1][-1]).to_a
    else
      coords[1][0].downto(coords[1][-1]).to_a
    end

  x_coords.each_index { |index| vents[[x_coords[index], y_coords[index]]] += 1 }
end

puts vents.values.count { |val| val > 1 }
