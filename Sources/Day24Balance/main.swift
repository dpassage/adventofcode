import Foundation
import AdventLib

let testInput = """
1
2
3
4
5
7
8
9
10
11
""".components(separatedBy: "\n").compactMap(Int.init).sorted(by: >)

let day24packages = """
1
3
5
11
13
17
19
23
29
31
37
41
43
47
53
59
67
71
73
79
83
89
97
101
103
107
109
113
""".components(separatedBy: "\n").compactMap(Int.init).sorted(by: >)

extension Array where Element == Int {
    func sum() -> Int {
        return self.reduce(0, +)
    }

    func product() -> Int {
        return self.reduce(1, *)
    }
}

// returns -1 if nothing possible
func bestLoad(packages: [Int], buckets: Int) -> Int {
    let targetLoadSize = packages.sum() / buckets
    guard packages.sum() % buckets == 0 else { return -1 }

    for i in 1..<packages.count {
        let combos = packages.combinations(n: i)
        let correctlySized = combos.filter { $0.sum() == targetLoadSize }
        let lowestProduct = correctlySized.map { $0.product() }.sorted()
        if let result = lowestProduct.first { return result }
    }

    return -1
}

print(bestLoad(packages: testInput, buckets: 3))
print(bestLoad(packages: day24packages, buckets: 3))

print(bestLoad(packages: testInput, buckets: 4))
print(bestLoad(packages: day24packages, buckets: 4))
