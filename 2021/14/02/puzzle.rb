RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

INSERTIONS = 10

inputs = File.readlines('../inputs').map(&:chomp)
template = inputs.first.chars
rules = inputs[2..].map { |rule| rule.split(' -> ') }.to_h
all_chars = (rules.to_a.join.chars + template).uniq
frequencies = all_chars.zip([0] * all_chars.size).to_h

template.each { |char| frequencies[char] += 1 }

def check_pair(segment, rules, frequencies, insertions)
  insertion ||= rules[segment]

  return if insertions.zero? || insertion.nil?

  frequencies[insertion] += 1

  check_pair("#{segment[0]}#{insertion}", rules, frequencies, insertions - 1)
  check_pair("#{insertion}#{segment[-1]}", rules, frequencies, insertions - 1)
end

puts
start = Time.now

template.each_cons(2) { |pair| check_pair(pair.join, rules, frequencies, INSERTIONS) if rules[pair.join] }

puts frequencies

puts
puts "Answer: #{frequencies.values.max - frequencies.values.min}"

puts
puts "Took #{((Time.now - start) * 1000).floor}ms"
