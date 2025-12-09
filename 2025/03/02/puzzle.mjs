import fs from 'fs'

const batteryBanks = fs.readFileSync('../inputs', 'utf8')
  .split('\n')
  .map(bank => bank
    .split('')
    .map(battery => +battery)
  )

const findHighestCapacity = (batteryBank) => (
  batteryBank.reduce((capacities, capacity, index, bank) => {
    const firstLowerIndex = capacities.findIndex(cap => cap < capacity)
    const spaceToGo = 12 - capacities.length
    const numbersLeft = bank.length - index

    if (firstLowerIndex < 0) {
        if (capacities.length >= 12) return capacities

        capacities.push(capacity)

        return capacities
      }

    if ((numbersLeft <= spaceToGo)) {
      capacities.push(capacity)

      return capacities
    }

    for (let i = firstLowerIndex; i <= capacities.length; i++) {
      if ((i + numbersLeft) >= 12) {
        capacities.splice(i, 1, capacity)

        return capacities.slice(0, i + 1)
      }
    }
    
    return capacities
  }, [0])
)

const sum = batteryBanks.reduce((sum, bank) => {
  const digits = findHighestCapacity(bank)

  return sum + +`${digits.join('')}`
}, 0)

console.log(sum)
