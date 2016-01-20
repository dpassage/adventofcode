
import AdventLib
import Foundation

func findFits(buckets: [Int], capacity: Int) -> [[Int]] {
    print("findFits buckets: \(buckets) capacity: \(capacity)")
    
    if buckets.count == 0 {
        return []
    }

    let top = buckets[0]
    let remaining = Array<Int>(buckets.dropFirst())

    var result = [[Int]]()

    if top > capacity {
        return []
    }

    if top == capacity {
        result.append([top])
    }

    result.appendContentsOf(findFits(remaining, capacity: capacity))

    let recurse = findFits(remaining, capacity: capacity - top)
    let recurseWithTop = recurse.map { inner -> [Int] in
        var result = [top]
        result.appendContentsOf(inner)
        return result
    }
    result.appendContentsOf(recurseWithTop)
    return result
}

guard Process.arguments.count > 1 else {
    print("specifiy a size")
    exit(1)
}

let capacity = Int(Process.arguments[1])!
print("capacity: \(capacity)")
let buckets = TextFile.standardInput().readLines().map { Int($0)! }.sort()

print("buckets: \(buckets)")

let result = findFits(buckets, capacity: capacity)
print("combos: \(result.count)")