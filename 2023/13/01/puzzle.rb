maps = File.readlines('../inputs')
  .map(&:chomp)
  .slice_when { |line| line.empty? }
  .map { |map| map.reject(&:empty?) }

def turn map
  map.map(&:chars).transpose.map(&:join)
end

def mirror_indices input
  input.each_cons(2).to_a.map.with_index do |pair, idx|
    pair.uniq.size == 1 ? idx : nil
  end.compact
end

def valid_mirror? input, idx
  halves = [input[0..idx].reverse, input[idx + 1..-1]]
  halves.map! { |half| half[0..halves.min_by(&:size).size - 1] }

  return halves.first == halves.last
end

total = 0

maps.each.with_index do |map, i|
  horizontal_mirror_indices = mirror_indices(map)
  valid_horizontal_mirror_indices = horizontal_mirror_indices.select { |idx|
    valid_mirror?(map, idx)
  }
  
  valid_horizontal_mirror_indices.each do |idx|
    total += (idx + 1) * 100
    next
  end

  turned_map = turn(map)
  vertical_mirror_indices = mirror_indices(turned_map)
  valid_vertical_mirror_indices = vertical_mirror_indices.select { |idx|
    valid_mirror?(turned_map, idx)
  }
  
  valid_vertical_mirror_indices.each do |idx|
    total += idx + 1
  end
end

p total
