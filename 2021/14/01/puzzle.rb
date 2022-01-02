INSERTIONS = 10

def insert_elements(polymer, rules, iterations)
  return polymer.join if iterations.zero?

  polymer = polymer.flat_map.with_index do |left, ind|
    right = polymer[ind + 1]
    segment = [left, right].join
    [ind.zero? ? left : nil, rules[segment], right]
  end

  insert_elements(polymer.compact, rules, iterations - 1)
end

def most_frequent_element_count(polymer)
  polymer.count(polymer.chars.max_by { |e| polymer.count(e) })
end

def least_frequent_element_count(polymer)
  polymer.count(polymer.chars.min_by { |e| polymer.count(e) })
end

inputs = File.readlines('../inputs').map(&:chomp)
template = inputs.first
rules = inputs[2..].map { |rule| rule.split(' -> ') }.to_h

start = Time.now

polymer = insert_elements(template, rules, INSERTIONS)

puts most_frequent_element_count(polymer) - least_frequent_element_count(polymer)

puts "Took #{((Time.now - start) * 1000).floor}ms"
