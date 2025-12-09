@precedence = %w(2 3 4 5 6 7 8 9 T J Q K A).zip(('a'..'m').to_a).to_h

def hand_type(cards)
  num_unique = cards.uniq.size

  return 7 if num_unique == 1
  return 2 if num_unique == 4
  return 1 if num_unique == 5

  if num_unique == 2
    return cards.any? { |card| cards.count(card) == 4 } ? 6 : 5
  end

  return cards.any? { |card| cards.count(card) == 3 } ? 4 : 3
end

rank_sum = File.readlines('../inputs').map(&:chomp)
  .map do |hand|
    data = hand.split(' ')
    cards = data.first
    bet = data.last.to_i
    type = hand_type(data.first.split(''))
    value = cards.split('').map { |card| @precedence[card] }.join

    {
      bet: bet,
      type: type,
      value: value,
    }
  end.sort_by! { |hand| [hand[:type], hand[:value]] }
  .map.with_index { |hand, idx| hand[:bet] * (idx + 1) }.sum

p rank_sum
