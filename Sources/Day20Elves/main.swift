import Foundation

func presents(n: Int) -> Int {
    var result = 0
    for i in 1 ... n {
        if n % i == 0 {
            result += i * 10
        }
    }
    return result
}

func firstHouseWithAtLeast(n: Int) -> Int {
    var result = 0
    while true {
        result += 1
        let delivered = presents(n: result)
        print("\(result): \(delivered)")
        if delivered >= n {
            break
        }
    }
    return result
}

print(firstHouseWithAtLeast(n: 33_100_000))
