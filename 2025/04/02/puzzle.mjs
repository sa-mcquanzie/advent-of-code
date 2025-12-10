import fs from 'fs'

const grid = fs.readFileSync('../inputs', 'utf8')
  .split('\n')
  .map((row) => (
    [...row].reduce((obj, roll, ci) => ({...obj, [ci]: +(roll === '@')}), {})
  )).reduce((obj, positions, ri) => ({...obj, [ri]: positions}), {})

const rowLength = Object.entries(grid).length
const colLength = Object.entries(grid[0]).length

let accessible = 0
let changed = true

while (changed) {
  changed = false

  for (let row = 0; row < rowLength; row++) {
    for (let col = 0; col < colLength; col++) {
      const roll = grid[row][col]
      
      if (roll) {
        const adjacent = [
          grid[row - 1]?.[col - 1], grid[row - 1]?.[col], grid[row - 1]?.[col + 1],
          grid[row]?.[col - 1], grid[row]?.[col + 1],
          grid[row + 1]?.[col - 1], grid[row + 1]?.[col], grid[row + 1]?.[col + 1]
        ]

        if (adjacent.filter(roll => roll).length < 4) {
          grid[row][col] = 0

          accessible++
          changed = true
        }
      }
    }
  }
}

console.log(accessible)
