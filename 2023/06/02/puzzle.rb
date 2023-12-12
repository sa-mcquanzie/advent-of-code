race = File.readlines('../inputs').map(&:chomp)
  .map { |line| line.split(':') }
  .map { |arr| arr.last.squeeze(' ').strip.split(' ').join.to_i }

def race_distance(press_time, race)
  remaining_time = race.first - press_time
  press_time * remaining_time
end

winning_move_product = 1
count = 0

1.upto(race.first - 1) do |press_time|
  result = race_distance(press_time, race)
  count += 1 if result > race.last
end

winning_move_product *= count unless(count.zero?)

p winning_move_product
