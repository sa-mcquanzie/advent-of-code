# TODO: Everything - this is a failure 😭

# require_relative '../../../shared/aoc_helpers'
# include AOC_Helpers

# class Resource
#   attr_reader :name, :prev, :ranges
#   attr_accessor :prev

#   def initialize(name, ranges)
#     @name = name
#     @ranges = ranges
#     @prev = nil
#   end
# end

# class Almanac
#   attr_reader :resources, :seeds, :highest_location_number

#   def initialize(resources, seeds, highest_location_number)
#     puts "Initializing Almanac..."

#     @resources = resources
#     @seeds = seeds
#     @highest_location_number = highest_location_number

#     @resources.each.with_index do |res, idx|
#       unless idx == 0
#         res.prev = resources[idx - 1]
#       end
#     end

#     puts "Finished initializing Almanac..."
#     puts "Smallest seed: #{smallest_seed}"
#   end

#   def seed_for_location(location_number, resource = resources.last)
#     match = resource.ranges.find { |range_map| range_map[1].include?(location_number) }
#     location_number = match[0].begin + (location_number - match[1].begin) if match

#     return location_number if resource.prev.nil?

#     resource = resource.prev

#     seed_for_location(location_number, resource)
#   end

#   def smallest_seed
#     @seeds.min_by(&:begin).begin
#   end

#   def lowest_location_number
#     lowest_location_number = Float::INFINITY

#     check_size = 0..highest_location_number.size

#     0.upto(highest_location_number).with_index do |location_number, idx|
#       p @resources.last.ranges
#       print "Checking: [#{location_number}/#{highest_location_number}] "

#       seed = seed_for_location(location_number)
#       print "Seed number: #{seed}"

#       if @seeds.any? { |range| range.include?(seed) }
#         if location_number < lowest_location_number
#           lowest_location_number = location_number
#           print " New lowest!\n"
#           @seeds.map! { |range| range = range.begin...range.begin + lowest_location_number}

#         else
#           print "\n"
#         end
#       else
#         print " No seed\n"
#       end
#     end

#     lowest_location_number
#   end
# end

# def parse_almanac(inputs)
#   puts "Parsing data..."
#   inputs.map!(&:chomp)

#   seeds = inputs.first.split(' ')[1..-1]
#     .map(&:to_i)
#     .each_slice(2).to_a
#     .map { |arr| arr.first...arr.first + arr.last }

#   data = inputs[1..-1].join(' ').strip.split('  ').map{ |i| i.split(': ') }
#     .map do |array|
#       ranges = array[1..-1].first.split(' ').map(&:to_i).each_slice(3).to_a.rotate.transpose
#       ranges = ranges.map { |arr| arr.map.with_index { |num, idx| num..num + ranges[-1][idx] } }
#       ranges = ranges[0..-2].transpose.zip.flatten(1).map(&:reverse)
#       name = array.first.split(' ').first.split('-to-').map(&:to_sym)
#       [name, ranges]
#     end

#   highest_location_number = data.map(&:last).last.map(&:last).max_by(&:end).end

#   resources = data.map do |array|
#     source_ranges = array.last.first
#     destination_ranges = array.last.last
#     resource = Resource.new(array.first.first, [source_ranges, destination_ranges])
#   end

#   puts "Finished parsing data..."
#   Almanac.new(resources, seeds, highest_location_number)
# end

# almanac = parse_almanac(File.readlines('../inputs'))

# def nth_term(enumerator, n)
#   n.times { enumerator.lazy.next }
#   enumerator.next
# end

# lowest_location_number = Float::INFINITY

# puts "Seeds: #{almanac.seeds}"

# # p almanac.lowest_location_number

# p almanac.resources.last.ranges