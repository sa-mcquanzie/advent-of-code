require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def create_hash(inputs)
  inputs_array = inputs.map(&:chomp)
    .map { |line| line.split(/[\|\:]/) }
    .map { |section| section.map { |text| text.strip.gsub(/\s+/, ' ') }}

  inputs_array.each_with_object({}) do |array, hash|
    id = array[0].split(' ')[1].to_i
    won = array[1].split(' ').map(&:to_i)
    matches = array[2].split(' ').map(&:to_i).select { |num| won.include?(num) }.size
    range = ((id + 1)..(id + matches))
    init_copy = !matches.zero?

    hash[id] = {
      matches: matches,
      match_range: range.begin <= range.end ? range : nil,
      copies: 1,
      copy: init_copy
    }
  end
end

def make_copies(card, cards)
  return if card[:matches].zero? || card[:copy] == false

  copied = []

  card[:match_range].each do |match_id|
    copy_card = cards[match_id]

    next unless copy_card

    copy_card[:copies] += 1
    copied << match_id
  end

  copied.each { |id| cards[id][:copy] = true unless cards[id][:matches].zero? }
  copied.each { |id| make_copies(cards[id], cards)}
end

def calculate_total_cards(cards)
  cards.each do |id, card|
    next if card[:copy] == false

    make_copies(card, cards)
    
    card[:copy] = false
  end

  cards.values.sum { |card| card[:copies] }
end

scratchcards = create_hash(File.readlines('../inputs'))

run_with_timer(method(:calculate_total_cards), scratchcards)
