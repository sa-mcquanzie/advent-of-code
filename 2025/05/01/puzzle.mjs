import fs from 'fs'

const [ranges, items] = fs.readFileSync('../inputs', 'utf8')
  .split('\n\n')
  .map(arr => arr.split('\n'))
  .map(arr => arr.map(i => i.split('-').map(i => +i)))
  .map((arr, ind) => ind === 1 ? arr.flat() : arr)

const smallestNumber = Math.max(Math.min(...items), Math.min(...ranges.map(r => r[0])))
const largestNumber = Math.min(Math.max(...items), Math.max(...ranges.map(r => r[1])))

let freshCount = 0

items.forEach(item => {
  if (
    (item >= smallestNumber && item <= largestNumber) &&
    ranges.some(range => (range[0] <= item && range[1] >= item))
  ) {
    freshCount++
  }
})

console.log(freshCount)
