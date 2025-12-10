import fs from 'fs'

const grid = fs.readFileSync('../inputs', 'utf8')
  .split('\n')
  .map(row => [...row])

let count = 0;

grid.forEach((row, ri) => {
  row.forEach((col, ci) => {
    if (col === '@') {
      const adjacent = [
        grid[ri - 1]?.[ci - 1], grid[ri - 1]?.[ci], grid[ri - 1]?.[ci + 1],
        grid[ri]?.[ci - 1],grid[ri]?.[ci + 1],
        grid[ri + 1]?.[ci - 1], grid[ri + 1]?.[ci], grid[ri + 1]?.[ci + 1]
      ]

      if (adjacent.filter(c => c === '@').length < 4) count++
    }
  })

  return count
})

console.log(count)
