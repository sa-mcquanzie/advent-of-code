INSERTIONS = 10

def check_pair(segment, rules, frequencies, insertions)
  return if insertions.zero?
  return unless rules[segment]

  frequencies[rules[segment]] += 1
  
  check_pair([segment[0], rules[segment]].join, rules, frequencies, insertions - 1)
  check_pair([rules[segment], segment[-1]].join, rules, frequencies, insertions - 1)
end

inputs = File.readlines('../inputs').map(&:chomp)
template = inputs.first.chars
rules = inputs[2..].map { |rule| rule.split(' -> ') }.to_h
all_chars = (rules.to_a.join.chars + template).uniq
frequencies = all_chars.zip([0] * all_chars.size).to_h

template.each { |char| frequencies[char] += 1 }

puts
start = Time.now

template.each_cons(2) { |pair| check_pair(pair.join, rules, frequencies, INSERTIONS) }

puts frequencies

puts
puts "Answer: #{frequencies.values.max - frequencies.values.min}"

puts
puts "Took #{((Time.now - start) * 1000).floor}ms"