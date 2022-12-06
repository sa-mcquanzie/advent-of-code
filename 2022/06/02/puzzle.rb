p File.readlines('../inputs')[0]
  .split('')
  .each_cons(14).with_index.to_a
  .find { |(chunk, index)| chunk.uniq.size == 14 }[1] + 14
  
