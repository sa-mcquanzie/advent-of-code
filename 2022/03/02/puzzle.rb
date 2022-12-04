require 'set'

priority = [('a'..'z'), ('A'..'Z')].flat_map(&:to_a).zip(1..52).to_a.to_h

p File.readlines('../inputs')
  .map(&:chomp)
  .each_slice(3)
  .to_a
  .map { |elf_group|
    elf_group.map { |rucksack|
      rucksack
        .chars
        .map { |item| priority[item] }
    }.map(&:to_set)
  }.map { |rucksack1, rucksack2, rucksack3|
    (rucksack1 & rucksack2 & rucksack3).to_a[0]
}.sum
