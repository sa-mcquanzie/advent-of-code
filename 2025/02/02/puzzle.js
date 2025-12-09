import fs from 'fs'

const idPairs = fs.readFileSync('../inputs', 'utf8')
  .split(',')
  .map(pair => pair.split('-').map(str => +str))

let sum = 0

idPairs.forEach(pair => {
  for (let id = pair[0]; id <= pair[1]; id++) {
    let isInvalid = false
    let magnitudes = []

    const idString = String(id)
    const maxMagnitude = idString.length / 2

    for (let len = 1; len <= maxMagnitude; len++) {
      if (idString.length % len === 0) magnitudes.push(len)
    }

    magnitudes.forEach((magnitude) => {
      const matcher = new RegExp(`.{${magnitude}}`, 'g')
      const chunks = idString.match(matcher)
      const uniqueValues = new Set(chunks)

      if (uniqueValues.size === 1) isInvalid = true
    })

    if (isInvalid) sum += id
  }
})

console.log(sum)
