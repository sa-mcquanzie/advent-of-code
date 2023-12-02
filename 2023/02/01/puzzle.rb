@max_green = 13
@max_red = 12
@max_blue = 14

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
    possible = (
      green_max <= @max_green &&
      red_max <= @max_red &&
      blue_max <= @max_blue
    )

    possible ? id : 0
  end.sum

p result
