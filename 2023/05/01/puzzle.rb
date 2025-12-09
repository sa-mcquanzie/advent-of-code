require_relative '../../../shared/aoc_helpers'
include AOC_Helpers

class Resource
  attr_reader :name, :next, :map

  def initialize(name, next_resource, map)
    @name = name
    # @next = next_resource
    @map = map
  end
end

class ResourceMap
  def initialize(source_starts, destination_starts, ranges)
    source_starts = source_starts
    destination_starts = destination_starts
    init_ranges = ranges

    @ranges = source_starts.zip(destination_starts, init_ranges)
      .map { |arr| arr.map{ |num| num...num + arr.last }[0..-2] }
  end

  def includes_source?(source)
    @ranges.any? { |arr| arr.first.include?(source) }
  end

  def ranges_including_source(source)
    @ranges.find { |arr| arr.first.include?(source) }
  end

  def destination_for_source(source)
    return source unless includes_source?(source)

    ranges = ranges_including_source(source)
    source_start = ranges_including_source(source).first.begin
    destination_start = ranges_including_source(source).last.begin
    source - source_start + destination_start
  end
end

def extract_resource_symbols(line)
  line.split(' ').first.split('-to-').map(&:to_sym)
end

def create_resource_map(line, resource_hash, source, destination)
  numbers = line.split(' ').map(&:to_i)
end 

def parse_almanac(inputs)
  inputs.map!(&:chomp)

  seeds = inputs.first.split(' ')[1..-1].map(&:to_i)

  data = inputs[1..-1].join(' ').strip.split('  ').map{ |i| i.split(': ') }
    .map do |array|
      [ extract_resource_symbols(array.first),
        array[1..-1].first.split(' ').map(&:to_i).each_slice(3).to_a ]
    end

  resources = data.map do |array|
    source_starts = array.last.map { |arr| arr[1] }
    destination_starts = array.last.map { |arr| arr.first }
    ranges = array.last.map { |arr| arr.last }
    resource_map = ResourceMap.new(source_starts, destination_starts, ranges)
    resource = Resource.new(array.first.first, array.first.last, resource_map)
  end

  { :seeds => seeds, :resources => resources }
end

def find_lowest_location_number(almanac)
  location_values = []

  almanac[:seeds].each do |s|
    location_value = almanac[:resources].inject(s) do |seed, resource|
      seed = resource.map.destination_for_source(seed)
    end

    location_values << location_value
  end

  location_values.min
end

almanac = parse_almanac(File.readlines('../inputs'))

run_with_timer(method(:find_lowest_location_number), almanac)

