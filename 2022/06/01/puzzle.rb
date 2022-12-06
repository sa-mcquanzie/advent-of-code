p File.readlines('../inputs')[0]
  .split('')
  .each_cons(4).with_index.to_a
  .find { |(chunk, index)| chunk.uniq.size == 4 }[1] + 4
  