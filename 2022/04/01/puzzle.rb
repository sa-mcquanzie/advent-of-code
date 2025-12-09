p File.readlines('../inputs')
  .map { |elf_pair| elf_pair.chomp.split(',')
    .map { |section_ids|
      section_ids.split('-').map(&:to_i)
    }
  }.map { |((a, b), (c, d))| 
    (a >= c && b <= d) || (c >= a && d <= b)
}.count(true)
