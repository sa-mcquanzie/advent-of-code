inputs = File.readlines('../inputs').map(&:chomp).reject(&:empty?)

@instructions = inputs.shift.split('').map do |dir|
  dir == 'R' ? :right : :left
end.cycle

@map = inputs.map do |row|
  parts = row.split(' = ')
  directions = parts.last[1..-2].split(', ')

  {parts.first.to_sym => {
    left: directions.first.to_sym,
    right: directions.last.to_sym
  }}
end.reduce(&:merge)

def count_steps
  steps = 0
  location = :AAA

  until location == :ZZZ
    steps += 1
    direction = @instructions.next
    location = @map[location][direction]
  end

  steps
end

p count_steps
