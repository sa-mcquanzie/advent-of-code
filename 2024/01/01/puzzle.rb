require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def calculate_total_difference
  File.readlines('../inputs')
    .map(&:chomp)
    .map(&:split)
    .map { |x| x.map(&:to_i) }
    .transpose
    .map(&:sort)
    .transpose
    .map { |a, b| (a - b).abs }
    .sum
end

run_with_timer(method(:calculate_total_difference))
