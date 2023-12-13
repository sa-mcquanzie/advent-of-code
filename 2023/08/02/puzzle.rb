inputs = File.readlines('../inputs').map(&:chomp).reject(&:empty?)

@instructions = inputs.shift.split('').map do |dir|
  dir == 'R' ? :right : :left
end.cycle

@map = inputs.map do |row|
  parts = row.split(' = ')
  node = parts.first.to_sym
  directions = parts.last[1..-2].split(', ')

  {node => {
    left: directions.first.to_sym,
    right: directions.last.to_sym,
    is_start_node: node.to_s.end_with?('A'),
    is_end_node: node.to_s.end_with?('Z')
  }}
end.reduce(&:merge)

def count_ghostly_steps(node)
  steps = 0

  until @map[node][:is_end_node]
    steps += 1
    direction = @instructions.next
    node = @map[node][direction]
  end

  @instructions.rewind
  
  steps
end

start_nodes = @map.select { |key, value| value[:is_start_node] == true }

p start_nodes.map { |key, value| count_ghostly_steps(key) }.inject(1, :lcm)
