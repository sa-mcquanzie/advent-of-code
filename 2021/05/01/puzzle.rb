inputs = File
         .readlines('../inputs')
         .map { |line| line.chomp.split(' -> ').map { |pair| pair.split(',').map(&:to_i) } }
         .map(&:transpose)
         .map { |coords| coords.map(&:sort) }
         .reject { |coords| coords[0][0] != coords[0][1] && coords[1][0] != coords[1][1] }

vents = Hash.new(0)

inputs.each do |coords|
  x_coords = coords[0][0]..coords[0][-1]
  y_coords = coords[1][0]..coords[1][-1]

  x_coords.each { |x| y_coords.each { |y| vents[[x, y]] += 1 } }
end

puts vents.values.count { |val| val > 1 }
