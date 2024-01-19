@exit_directions = {
  '|' => [[0, -1], [0,  1]],
  '-' => [[-1, 0], [1,  0]],
  'L' => [[0, -1], [1,  0]],
  'J' => [[0, -1], [-1, 0]],
  '7' => [[-1, 0], [0,  1]],
  'F' => [[0,  1], [1,  0]],
  'S' => [[0, -1], [0,  1]],
  '.' => []
}

def create_field(input)
  pipes = input.map.with_index do |row, row_idx|
    cols = row.map.with_index do |legend, col_idx|
      directions = @exit_directions[legend].dup
      exits = directions.delete_if do |co_ord|
        row_idx.zero? && co_ord.last.negative? ||
        col_idx.zero? && co_ord.first.negative? ||
        col_idx == row.length - 1 && co_ord.first.positive? ||
        row_idx == input.length - 1 && co_ord.last.positive?
      end

      exits.map! { |co_ord| [co_ord.first + col_idx, co_ord.last + row_idx] }

      {[col_idx, row_idx] =>
        {
          legend: legend,
          exits: exits,
          start?: legend == 'S',
          visited?: false
        }
      }
    end
  end
    .flatten
    .inject(&:merge)
    .delete_if { |key, value| value[:dead_end] == true }

  pipes
end

def take_steps(start_co_ords, pipes, distance)
  stack = [[start_co_ords, distance]]

  until stack.empty?
    co_ords, distance = stack.pop
    pipes[co_ords][:visited?] = true

    distance += 1

    next_pipe_co_ords = pipes[co_ords][:exits].find do |exit_co_ords|
      pipes[exit_co_ords][:visited?] == false
    end

    return distance if next_pipe_co_ords.nil?

    stack.push([next_pipe_co_ords, distance])
  end
end

def find_max_steps(pipes)
  start = pipes[pipes.find { |key, val| val[:start?] == true }.first]

  result = (take_steps(start[:exits].first, pipes, 0) / 2).ceil
  p result
  return result
end

input = File.readlines('../inputs').map(&:chomp).map(&:chars)
pipes = create_field(input)

find_max_steps(pipes)
