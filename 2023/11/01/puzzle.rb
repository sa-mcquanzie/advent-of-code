universe = File.readlines('../inputs')
  .map(&:chomp)
  .map(&:chars)

xy_lookup = {
  x: 0.upto(universe[0].length - 1).zip(0.upto(universe[0].length - 1)).to_h,
  y: 0.upto(universe.length - 1).zip(0.upto(universe.length - 1)).to_h
}

universe.each.with_index do |row, ri|
  if row.all? { |c| c == '.' }
    xy_lookup[:y].select { |k, _| k > ri }.each do |k, v|
      xy_lookup[:y][k] += 1
    end
  end
end

universe.transpose.each.with_index do |col, ci|
  if col.all? { |c| c == '.' }
    xy_lookup[:x].select { |k, _| k > ci }.each do |k, v|
      xy_lookup[:x][k] += 1
    end
  end
end

galaxies = universe.map.with_index do |row, ri|
  row.map.with_index do |col, ci|
    col == '#' ? [xy_lookup[:x][ci], xy_lookup[:y][ri]] : []
  end
end.flatten(1).reject(&:empty?)

sum = galaxies.combination(2).to_a.map do |pair|
  pair
    .transpose
    .map(&:minmax)
    .map { |xy| xy.last - xy.first }
end.inject(:+).sum

p sum
