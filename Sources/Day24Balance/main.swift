import Foundation

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

print(testInput)
struct Sleigh {
    var front: [Int] = []
    var left: [Int] = []
    var right: [Int] = []

    var frontPackages: Int { return front.count }
    var quantumEntanglement: Int { return front.reduce(1, *) }

    var balanced: Bool {
        let frontWeight = front.reduce(0, +)
        let leftWeight = left.reduce(0, +)
        let rightWeight = right.reduce(0, +)
        return frontWeight == leftWeight && frontWeight == rightWeight
    }

    func allBelow(limit: Int) -> Bool {
        let frontWeight = front.reduce(0, +)
        let leftWeight = left.reduce(0, +)
        let rightWeight = right.reduce(0, +)

        return frontWeight <= limit && leftWeight <= limit && rightWeight <= limit
    }
}

// given a partially loaded sleigh and list of remaining packages, return all valid fully
// loaded sleighs.

func load(sleigh: Sleigh, remainingPackages: [Int], limit: Int) -> Sleigh? {
    guard !remainingPackages.isEmpty else { return sleigh }
    var remainingPackages = remainingPackages
    let nextPackage = remainingPackages.removeFirst()

    var result = [Sleigh]()
    // The package can go in three places: front, left, right
    var addedToFront = sleigh
    addedToFront.front.append(nextPackage)
    if addedToFront.allBelow(limit: limit) {
        if let recur = load(sleigh: addedToFront, remainingPackages: remainingPackages, limit: limit) {
            result.append(recur)
        }
    }

    var addedToLeft = sleigh
    addedToLeft.left.append(nextPackage)
    if addedToLeft.allBelow(limit: limit) {
        if let recur = load(sleigh: addedToLeft, remainingPackages: remainingPackages, limit: limit) {
            result.append(recur)
        }
    }
    var addedToRight = sleigh
    addedToRight.right.append(nextPackage)
    if addedToRight.allBelow(limit: limit) {
        if let recur = load(sleigh: addedToRight, remainingPackages: remainingPackages, limit: limit) {
            result.append(recur)
        }
    }

    return result.sorted { (lhs, rhs) -> Bool in
        if lhs.frontPackages == rhs.frontPackages {
            return lhs.quantumEntanglement < rhs.quantumEntanglement
        }
        return lhs.frontPackages < rhs.frontPackages
    }.first
}


func generate(packages: [Int]) -> Sleigh? {
    let limit = packages.reduce(0, +) / 3

    var remainingPackages = packages
    let nextPackage = remainingPackages.removeFirst()

    let front = Sleigh(front: [nextPackage], left: [], right: [])

    let fronts = load(sleigh: front, remainingPackages: remainingPackages, limit: limit)
    return fronts
}

let testLoads = generate(packages: testInput)
print(testLoads!.quantumEntanglement)

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

let day24loads = generate(packages: day24packages)

print(day24loads!.quantumEntanglement)
