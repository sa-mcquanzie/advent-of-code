inputs = File.readlines('../inputs').map(&:chomp)

numbers = inputs[0].split(',').map(&:to_i)

boards = inputs[2..].each_slice(6).to_a.map do |board|
  board.delete_if { |row| row.empty? }
  board.map { |row| row.split(' ').map(&:to_i) }
end

def winning_score(board, number)
  board.flatten.reject { |x| x == true }.sum * number
end

winners = []

numbers.each do |number|
  boards.each.with_index do |board, index|
    next if winners.map { |e| e.first }.include? index

    board.each do |row|
      row.map! { |n| n == number ? true : n }

      winners << [index, number] if row.count(true) == 5
    end

    board.transpose.each do |col|
      winners << [index, number] if col.count(true) == 5
    end
  end
end

puts winning_score(boards[winners.last.first], winners.last.last)
