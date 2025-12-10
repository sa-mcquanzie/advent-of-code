import fs from 'fs'

const freshIds = fs.readFileSync('../inputs', 'utf8')
  .split('\n\n')[0]
  .split('\n')
  .map(r => r.split('-').map(n => +n))
  .sort((a,b) => a[0] - b[0])
  .reduce((prev, curr) => {
    const last = prev.at(-1)

    if (curr[0] >= last[0] && curr[1] <= last[1]) return prev

    if (curr[0] <= last[0] && curr[1] >= last[1]) return [...prev.slice(0, -1), curr]

    if (curr[0] >= last[0] && curr[1] >= last[1] && curr[0] <= last[1]) {
      return [...prev.slice(0, -1), [last[0], curr[1]]]
    }

    return [...prev, curr]
  }, [[Infinity, -Infinity]]).reduce((tally, curr) => (tally + (curr[1] - curr[0]) + 1), 0)

console.log(freshIds)
