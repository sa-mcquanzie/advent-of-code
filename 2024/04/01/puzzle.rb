require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def get_wordsearch inputs
  inputs.map(&:chomp).map(&:split).map(&:first).map { |line| line.split('') }
end

def count_horizontals line
  count = 0

  line.each_cons(4) do |chunk|
    count += 1 if chunk.join == "XMAS" 
    count += 1 if chunk.join == "SAMX"
  end

  count
end

def count_verticals chunk
  count = 0

  chunk.first.each.with_index do |char, index|
    column = [chunk[1][index], chunk[2][index], chunk[3][index]]
    
    count += 1 if char == "X" && column.join == 'MAS' 
    count += 1 if char == "S" && column.join == 'AMX' 
  end

  count
end

def count_diagonals chunk
  count = 0

  chunk.first.each.with_index do |char, index|
    left_diagonal  = [chunk[1][index - 1], chunk[2][index - 2], chunk[3][index - 3]]
    right_diagonal = [chunk[1][index + 1], chunk[2][index + 2], chunk[3][index + 3]]

    if index > 2
      count += 1 if char == "X" && left_diagonal.join == 'MAS'
      count += 1 if char == "S" && left_diagonal.join == 'AMX'
    end

    if index < chunk.first.length - 2
      count += 1 if char == "X" && right_diagonal.join == 'MAS'
      count += 1 if char == "S" && right_diagonal.join == 'AMX'
    end
  end

  count
end

def xmas_count wordsearch
  wordsearch.map { |row| count_horizontals row }.sum +
  wordsearch.each_cons(4).map { |chunk| count_verticals chunk }.sum +
  wordsearch.each_cons(4).map { |chunk| count_diagonals chunk }.sum 
end

inputs = File.readlines '../inputs'
wordsearch = get_wordsearch inputs

run_with_timer(method(:xmas_count), wordsearch)
