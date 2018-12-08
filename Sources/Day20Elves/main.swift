import Foundation

func firstHouseWithAtLeast(n: Int) -> Int {
    let target = n / 10

    var houses = [Int](repeating: 1, count: target)

    for elf in 2..<target {
        var i = elf
        while i < target {
            houses[i] += elf
            i += elf
        }
    }
    // find first
    for i in 0..<target where houses[i] >= target { return i }
    return -1
}

print(firstHouseWithAtLeast(n: 33100000))

func elfTwo(limit n: Int) -> Int {
    let houseCount = n / 11
    var houses = [Int](repeating: 1, count: houseCount)

    for elf in 1..<houseCount {
        var house = elf
        var count = 0
        while house < houseCount && count < 50 {
            houses[house] += (elf * 11)
            house += elf
            count += 1
        }
    }

    // find first
    for i in 0..<houseCount where houses[i] >= n { return i }
    return -1
}

print(elfTwo(limit: 33100000))
