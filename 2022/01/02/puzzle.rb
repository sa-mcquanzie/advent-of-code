p File.readlines('../inputs')
  .map { |x| x.chomp.to_i }
  .slice_when { |x| x.zero? }
  .to_a
  .map(&:sum)
  .sort[-3..-1]
  .sum