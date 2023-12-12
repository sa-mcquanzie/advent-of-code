@precedence = %w(J 2 3 4 5 6 7 8 9 T Q K A).zip(('a'..'z').to_a).to_h

def upgrade_jokers(cards)
  return cards unless cards.include?('J') && cards.count('J') < 5

  best_upgrade = @precedence.keys.reverse
    .select { |card| cards.delete('J').include?(card) }
    .sort_by { |card| [cards.count(card), @precedence.keys.index(card)] }
    .last

  cards.gsub('J', best_upgrade)
end

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
    upgraded_cards = upgrade_jokers(cards)
    bet = data.last.to_i
    upgraded_type = hand_type(upgraded_cards.split(''))
    original_value = cards.split('').map { |card| @precedence[card] }.join

    {
      bet: bet,
      upgraded_type: upgraded_type,
      original_value: original_value,
    }
  end.sort_by! { |hand| [
    hand[:upgraded_type],
    hand[:original_value]
  ]}
  .map.with_index { |hand, idx| hand[:bet] * (idx + 1) }.sum

p rank_sum
