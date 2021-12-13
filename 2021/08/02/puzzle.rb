def segments_include?(str1, str2) = str1.chars.all? { |char| str2.chars.include? char }

data = File.readlines('../inputs').map do |line|
  line.chomp.split(' | ').map(&:split).map { |x| x.map { |y| y.chars.sort.join } }
end

answer = []

data.each do |input, output|
  decoded = (0..9).to_a.zip([]).to_h

  # Find the digits that can be deduced from length only
  input.each do |digit|
    case digit.length
    when 2 then decoded[1] = digit
    when 3 then decoded[7] = digit
    when 4 then decoded[4] = digit
    when 7 then decoded[8] = digit
    end
  end

  # Find the 3 - the only digit of segment length 5 that includes both segments of 1
  input.select { |d| decoded.values.none?(d) }.each do |digit|
    decoded[3] = digit if digit.length == 5 && (segments_include?(decoded[1], digit))
  end

  # Distinguish between the 6-segment digits by diffing their segments with those of 3 & 7
  input.select { |d| decoded.values.none?(d) }.each do |digit|
    if digit.length == 6
      segments_include?(decoded[3], digit) ? decoded[9] = digit :
      segments_include?(decoded[7], digit) ? decoded[0] = digit : decoded[6] = digit
    end
  end

  # Distinguish between the remaining 5-segment digits by diffing them with the segments of 9
  input.select { |d| decoded.values.none?(d) }.each do |digit|
    if digit.length == 5
      segments_include?(digit, decoded[9]) ? decoded[5] = digit : decoded[2] = digit
    end
  end

  output.each { |digit| answer << decoded.invert[digit] }
end

puts answer.each_slice(4).map { |e| e.join.to_i }.sum
