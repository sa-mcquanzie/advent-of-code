final_score = File.readlines('../inputs').map { |round|
  round
    .chomp
    .gsub(/[A]/, '1').gsub(/[B]/, '2').gsub(/[C]/, '3')
    .split
}.map { |(elf_move, instruction)|
  elf_score = elf_move.to_i
  [ instruction == 'Y' ? 3 : instruction == 'Z' ? 6 : 0,
    instruction == 'Y' ? elf_score : instruction == 'Z' ? (elf_score % 3) + 1 : elf_score == 1 ? 3 : elf_score - 1
  ]
  .sum
}.sum

p final_score
