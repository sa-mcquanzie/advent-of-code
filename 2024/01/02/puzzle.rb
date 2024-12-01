require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def calculate_similarity_score
  list_a, list_b = File.readlines('../inputs')
    .map(&:chomp)
    .map(&:split)
    .map { |x| x.map(&:to_i) }
    .transpose

  list_a.map { |num| num * list_b.count(num) }.sum
end

run_with_timer(method(:calculate_similarity_score))
