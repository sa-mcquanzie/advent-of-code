import fs from 'fs'

const idPairs = fs.readFileSync('../inputs', 'utf8')
  .split(',')
  .map(pair => pair.split('-').map(str => +str))

let sum = 0

idPairs.forEach(pair => {
  for (let id = pair[0]; id <= pair[1]; id++) {
    const str = String(id)

    if (str.length % 2 !== 0) continue

    if (str.slice(0, str.length / 2) === str.slice(str.length / 2)) sum += id
  }
})

console.log(sum)
