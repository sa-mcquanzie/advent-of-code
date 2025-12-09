def adjacent(coords, sea)
  x, y = coords

  [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x + 1, y],
  [x + 1, y + 1], [x, y + 1], [x - 1, y + 1], [x - 1, y]]
  .select { |coords| sea.keys.include? coords }
end

def any_charged_octopi?(sea, flashed)
  !charged_octopi(sea, flashed).empty?
end

def charged_octopi(sea, flashed)
  sea.select { |octopus, charge| charge > 9 && flashed.none?(octopus) }.keys
end

def step(sea)
  flashed = []

  sea.transform_values! { |v| v + 1 }

  while any_charged_octopi?(sea, flashed)
    charged_octopi(sea, flashed).each do |octopus|
      flashed << octopus

      adjacent(octopus, sea).each do |neighbouring_octopus|
        sea[neighbouring_octopus] += 1
      end
    end
  end

  flashed.each { |octopus| sea[octopus] = 0 }
end

inputs = File.readlines('../inputs').map { |s| s.chomp.chars.map(&:to_i) }
sea = {}
steps = 0

inputs.each_with_index do |row, y|
  row.each_with_index do |charge, x|
    sea[[x,y]] = charge
  end
end

until sea.values.all? 0
  steps += 1
  step(sea)
end

puts steps
