require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def get_map inputs
  inputs.map(&:chomp)
end

def navigate position, map, direction, steps
  dir = direction.next
  x_position, y_position = position

  case dir
  when :north
    obstacle = map[0...y_position].rindex { |row| row[x_position] == "#" }

    p "No obstacle found to the #{dir} of #{position}" if not obstacle
    return steps + y_position - 1 if not obstacle

    new_position = [x_position, obstacle + 1]
    steps += (y_position - obstacle - 1)
    p "went #{dir}, to #{new_position}"
    p "Obstacle at #{obstacle}"

    return navigate(new_position, map, direction, steps)
  when :east
    obstacle = map[y_position].index("#")

    p "No obstacle found to the #{dir} of #{position}" if not obstacle
    return steps + x_position - 1 if not obstacle

    steps += (obstacle - x_position - 1)
    new_position = [obstacle - 1, y_position]
    p "went #{dir}, to #{new_position}"
    p "Obstacle at #{obstacle}"

    return navigate(new_position, map, direction, steps)
  when :south
    obstacle = map[y_position..-1].index { |row| row[x_position] == "#" }

    p "No obstacle found to the #{dir} of #{position}" if not obstacle
    return steps + (map.length + 1 - y_position) if not obstacle

    steps += (obstacle - y_position)
    new_position = [x_position, obstacle - 1]
    p "went #{dir}, to #{new_position}"
    p "Obstacle at #{obstacle}"

    return navigate(new_position, map, direction, steps)
  when :west
    obstacle = map[y_position].index("#")

    p "No obstacle found to the #{dir} of #{position}" if not obstacle
    return steps + x_position if not obstacle

    new_position = [obstacle + 1, y_position]
    steps += (x_position - obstacle - 1)
    p "went #{dir}, to #{[obstacle + 1, y_position]}"
    p "Obstacle at #{obstacle}"

    return navigate(new_position, map, direction, steps)
  else
  end
end


map = get_map(File.readlines '../test_inputs')
y_position = map.index { |row| row.include? "^" }
x_position = map[y_position].index "^"
direction = [:north, :east, :south, :west].cycle

p navigate([x_position, y_position], map, direction, 1)



# run_with_timer(method())
