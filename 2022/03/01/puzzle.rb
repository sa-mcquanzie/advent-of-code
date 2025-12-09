require 'set'

priority = [('a'..'z'), ('A'..'Z')].flat_map(&:to_a).zip(1..52).to_a.to_h

p File.readlines('../inputs').map { |rucksack|
  rucksack
    .chomp
    .chars
    .map { |item| priority[item] }
    .each_slice(rucksack.size / 2)
    .to_a
    .map(&:to_set)
  }.map { |(left_container, right_container)|
    (left_container & right_container).to_a[0]
}.sum
