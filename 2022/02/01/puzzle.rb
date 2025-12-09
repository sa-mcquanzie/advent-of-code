final_score = File.readlines('../inputs').map { |round|
  round
    .chomp
    .gsub(/[AX]/, '1').gsub(/[BY]/, '2').gsub(/[CZ]/, '3')
    .split
    .map(&:to_i)
}.map { |(elf_score, human_score)|
  [ elf_score == human_score ? 3 : elf_score % 3 + 1 == human_score ? 6 : 0,
    human_score
  ].sum
}.sum

p final_score
