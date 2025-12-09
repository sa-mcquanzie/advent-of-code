require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def is_safe? report
  diffs = report.each_cons(2).to_a.map { |pair| pair.inject(&:-) }

  (diffs.all?(&:positive?) || diffs.all?(&:negative?)) &&
  (diffs.map(&:abs).all? { |diff| diff < 4 })
end

def safe_reports reports
  reports.map{ |report| is_safe? report }.count(true)
end

inputs = File.readlines('../inputs').map(&:chomp).map(&:split).map { |line| line.map(&:to_i) }

run_with_timer(method(:safe_reports), inputs)
