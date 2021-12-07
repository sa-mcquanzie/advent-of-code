DAYS = 80

fishes = Array.new(9, 0)
File.read('../inputs').chomp.split(',').map(&:to_i).each { |stage| fishes[stage] += 1 }

DAYS.times do
  birthing_fish = fishes.first
  fishes.rotate!
  fishes[6] += birthing_fish
end

puts fishes.sum
