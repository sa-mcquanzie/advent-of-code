scratchcards = File.readlines('../inputs')
  .map(&:chomp)
  .map { |line| line.split(/[\|\:]/) }
  .map { |section| section.map { |text| text.strip.gsub(/\s+/, ' ') }}
  .map do |array|
    winning_numbers = array[1].split(' ').map(&:to_i)
    score = array[2].split(' ')
      .map(&:to_i)
      .select { |num| winning_numbers.include?(num) }
      .each.with_index.reduce(0) { |_, (_, index)| 2 ** index }

    score
  end

p scratchcards.sum
