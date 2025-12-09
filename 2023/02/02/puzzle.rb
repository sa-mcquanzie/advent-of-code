green = /(\d+)(?: green)/
red = /(\d+)(?: red)/
blue = /(\d+)(?: blue)/

def max_of_color(color, rounds)
  rounds.map { |round| round.scan(color).flatten.map(&:to_i) }.flatten.max
end

result = File.readlines('../inputs')
  .map(&:chomp)
  .map do |line|
    id_string, game = line.split(':')
    rounds = game.split(';').map(&:strip)
    id = id_string.split(' ').last.to_i
    green_max = max_of_color(green, rounds)
    red_max = max_of_color(red, rounds)
    blue_max = max_of_color(blue, rounds)

    green_max * red_max * blue_max
  end.sum

p result