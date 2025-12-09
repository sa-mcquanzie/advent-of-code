(tower_inputs, move_inputs) = File.readlines('../inputs')
  .map(&:chomp)
  .reject { |line| line.empty? || line.chars.all? { |char| /[0-9 ]/.match char }}
  .chunk { |line| line.start_with? 'move' }
  .to_a
  .map(&:last)

towers = tower_inputs.map do |row|
  row
    .gsub('    ', '.')
    .gsub(/[\[\] ]/, '')
    .split('')
    .map { |crate| crate.include?('.') ? nil : crate }
end
  .transpose
  .map(&:reverse)
  .map(&:compact)

moves = move_inputs.map(&:split).map do |(_, amount, _, origin, _, destination)|
  [amount.to_i, origin.to_i - 1, destination.to_i - 1]
end

moves.each do |(amount, origin, destination)|
  amount.times do
    towers[destination].push towers[origin].pop
  end
end

p towers.map(&:last).join
