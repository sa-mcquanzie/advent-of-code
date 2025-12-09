require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def get_instructions inputs
  inputs.scan(/don't\(\)|do\(\)|mul\(\d+,\d+\)/)
    .flatten
    .map do |instruction|
      instruction.include?("mul") ?
        instruction.scan(/\d+,\d+/).first.split(',').map(&:to_i).inject(&:*) :
        instruction
    end
    .prepend("do()")
end

def solve_by_array_methods inputs
  instructions = get_instructions(inputs)

  instructions
    .slice_before { |instruction| instruction === "do()" || instruction === "don't()" }
    .to_a
    .reject { |slice| slice.first === "don't()" }
    .map { |slice| slice.drop(1) }
    .flatten
    .sum
end

def solve_by_looping inputs
    instructions = get_instructions(inputs)

    sum = 0
    multiply = true

    instructions.each do |instruction|
      if instruction == ("do()")
        multiply = true
        next
      end

      if instruction == ("don't()")
        multiply = false
        next
      end

      if multiply
        sum = sum + instruction
      end
    end

    sum
end

inputs = File.read('../inputs').chomp

run_with_timer(method(:solve_by_array_methods), inputs)
run_with_timer(method(:solve_by_looping), inputs)
