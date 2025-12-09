require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def multiply_all inputs
  inputs.scan(/(?<=mul\()(\d+\,\d+)(?:\))/)
    .map(&:join)
    .map{ |pair| pair.split(",").map(&:to_i).inject(&:*) }
    .sum
end

inputs = File.read('../inputs').chomp

run_with_timer(method(:multiply_all), inputs)
