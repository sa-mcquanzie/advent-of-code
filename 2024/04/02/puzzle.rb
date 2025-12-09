require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def get_wordsearch inputs
  inputs.map(&:chomp).map(&:split).map(&:first).map { |line| line.split('') }
end

def xmas_count wordsearch
  x_mas_strings = [
    "MMASS",
    "MSAMS",
    "SMASM",
    "SSAMM"
  ]

  count = 0

  wordsearch.each_cons(3) do |rows|
    rows.first.each_cons(3).with_index do |cols, index|
      x_string = [
        cols.select.with_index{ |char, ind| ind.even? },
        rows[1][index + 1],
        rows[2][index .. index + 2].select.with_index{ |char, ind| ind.even? }
      ].join

      count += 1 if x_mas_strings.include? x_string
    end
  end

  count
end

inputs = File.readlines '../inputs'
wordsearch = get_wordsearch inputs

run_with_timer(method(:xmas_count), wordsearch)
