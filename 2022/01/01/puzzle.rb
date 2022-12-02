p File.readlines('../inputs')
  .map { |calories| calories.chomp.to_i }
  .slice_when { |calories| calories.zero? }
  .to_a
  .map(&:sum)
  .max