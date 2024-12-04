require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

def all_within_range?(diffs) diffs.map(&:abs).all? { |diff| diff < 4 } end
def all_positive?(diffs) diffs.all?(&:positive?) end
def all_negative?(diffs) diffs.all?(&:negative?) end

def all_diffs_valid? diffs
  ((all_positive?(diffs) || all_negative?(diffs))) && all_within_range?(diffs)
end

def get_diffs report
  report.each_cons(2).to_a.map { |pair| pair.inject(&:-) }
end

def is_safe? report
  if all_diffs_valid?(get_diffs(report)) then return true end

  safe = false

  report.each.with_index do |arr, index|
    new_report = report.dup
    new_report.delete_at(index)
    new_diffs = get_diffs(new_report)

    if all_diffs_valid?(new_diffs)
      safe = true
      break
    end
  end

  return safe
end

def safe_reports reports
  reports.map{ |report| is_safe?(report) }.count(true)
end

inputs = File.readlines('../inputs').map(&:chomp).map(&:split).map { |line| line.map(&:to_i) }

run_with_timer(method(:safe_reports), inputs)
