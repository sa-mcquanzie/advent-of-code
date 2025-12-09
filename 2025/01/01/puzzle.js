import fs from 'fs'

const turns = fs.readFileSync('../inputs', 'utf8').split('\n')

const result = turns.reduce(([pointer, count_zero], turn) => {
  const num = +turn.slice(1)

  const newPointer = turn.startsWith('R')
    ? (pointer + num) % 100
    : (100 + (pointer - num) % 100) % 100

  if (newPointer === 0) count_zero++
  
  return [newPointer, count_zero]
}, [50, 0])[1]

console.log('result:', result)
