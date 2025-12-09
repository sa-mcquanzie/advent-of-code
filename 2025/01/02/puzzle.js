import fs from 'fs'

const turns = fs.readFileSync('../inputs', 'utf8').split('\n')

const result = turns.reduce(([pointer, total_times_past_zero], turn) => {
  const clockwise = turn.startsWith('R')
  const num_turns = +turn.slice(1)

  let times_past_zero = 0

  for (let i = 0; i < num_turns; i++) {
    if (pointer === -1) pointer = 99
    if (pointer === 100) pointer = 0
    if (pointer === 0) times_past_zero++

    clockwise ? pointer++ : pointer --
  }

  return [pointer, total_times_past_zero + times_past_zero]
}, [50, 0])[1]

console.log('result:', result)
