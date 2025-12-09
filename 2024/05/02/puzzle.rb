require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def get_data inputs
  rules, updates = inputs
    .map(&:chomp)
    .slice_before(&:empty?)
    .to_a
    .map { |arr| arr.reject(&:empty?)}

  updates.map! { |update| update.split(',').map(&:to_i) }
  rules.map! { |rule| rule.scan(/\d+/) }.map! { |rule| rule.map(&:to_i) }
  unique_values = rules.flatten.uniq

  rules_as_hash = unique_values.each_with_object(Hash.new(0)) do |key, hash|
    hash[key] = rules.select { |rule| rule.last == key }.map(&:first)
  end

  [updates, rules_as_hash]
end

def correctly_ordered? update, rules_hash
  reverse_update = update.reverse

  reverse_update.each.with_index do |num, index|
    return false if reverse_update[0..index].any? { |n| rules_hash[num].include? n }
  end

  true
end

def correct_update update, rules
  return update if correctly_ordered?(update, rules)

  update.each.with_index do |num, index|
    should_preceed = update[index..].select { |n| rules[num].include? n }

    next if should_preceed.empty?

    last_preceeding_index = update.rindex { |n| should_preceed.include? n }
    new_update = update.dup

    new_update.slice!(index)
    new_update.insert(last_preceeding_index, num)

    return correct_update(new_update, rules)
  end
end

def incorrectly_ordered_updates_middle_values_sum updates, rules
  updates
    .select { |update| !correctly_ordered?(update, rules) }
    .map { |update| correct_update(update, rules) }
    .map { |update| update[(update.length / 2).floor] }
    .sum
end

updates, rules = get_data(File.readlines '../inputs')

run_with_timer(method(:incorrectly_ordered_updates_middle_values_sum), updates, rules)
