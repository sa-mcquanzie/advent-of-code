races = File.readlines('../inputs').map(&:chomp)
  .map { |line| line.split(':') }
  .map { |arr| arr.last.squeeze(' ').strip.split(' ').map(&:to_i) }
  .transpose
  .map { |arr| { time: arr.first, winning_distance: arr.last }}

def race_distance(press_time, race)
  remaining_time = race[:time] - press_time
  press_time * remaining_time
end

winning_move_product = 1

races.each do |race|
  count = 0

  1.upto(race[:time] - 1) do |press_time|
    result = race_distance(press_time, race)
    count += 1 if result > race[:winning_distance]
  end

  winning_move_product *= count unless(count.zero?)
end

p winning_move_product
