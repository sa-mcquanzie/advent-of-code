import fs from 'fs'

const batteryBanks = fs.readFileSync('../inputs', 'utf8')
  .split('\n')
  .map(bank => bank
    .split('')
    .map(battery => +battery)
  )

const findHighestCapacity = (batteryBank) => (
  batteryBank.reduce(({ first, second }, capacity, index, bank) => {
    if (capacity > first && index !== bank.length - 1) {
      return { first: capacity, second: 0 }
    }

    if (capacity > second) return { first, second: capacity }

    return { first, second }
  }, { first: 0, second: 0 })
)

const sum = batteryBanks.reduce((sum, bank) => {
  const digits = findHighestCapacity(bank)
  return sum + +`${digits.first}${digits.second}`
}, 0)

console.log(sum)
