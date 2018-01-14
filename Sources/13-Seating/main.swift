import Foundation
import AdventLib

var names = Set<String>()
var distances = [String: Int]()

let regex = try! Regex(pattern: "^([a-zA-Z]+) would (gain|lose) (\\d+) happiness units by sitting next to ([a-zA-Z]+)\\.")

func readLine(input: String) {
    guard let match = regex.match(input: input) else { return }
    guard match.count == 4 else { return }

    let left = match[0]
    let right = match[3]
    let distance = Int(match[2])! * ((match[1] == "gain") ? 1 : -1)

    names.insert(left)
    names.insert(right)

    distances["\(left) -> \(right)"] = distance
}

let lines = TextFile.standardInput().readLines()

for line in lines {
    readLine(input: line)
}

print(names)
print(distances)

if CommandLine.arguments.count > 1 && CommandLine.arguments[1] == "--hank" {
    names.insert("Hank")
}

extension Array {
    func convolute() -> [[Element]] {
        if count == 0 {
            return []
        }
        if count == 1 {
            return [[self[0]]]
        }

        var result = Array<Array<Element>>()
        for (index, item) in self.enumerated() {
            var remaining = self
            remaining.remove(at: index)

            for sublist in remaining.convolute() {
                var newlist = sublist
                newlist.insert(item, at: 0)
                result.append(newlist)
            }
        }

        return result
    }
}

let routes = [String](names).convolute()

func cost(route: [String]) -> Int {
    guard route.count >= 2 else { return 0 }

    var result = 0
    for i in 0 ..< route.count - 1 {
        let segment = "\(route[i]) -> \(route[i + 1])"
        let otherSegment = "\(route[i + 1]) -> \(route[i])"
        result += distances[segment] ?? 0
        result += distances[otherSegment] ?? 0
    }
    let segment = "\(route[0]) -> \(route[route.count - 1])"
    let otherSegment = "\(route[route.count - 1]) -> \(route[0])"
    result += distances[segment] ?? 0
    result += distances[otherSegment] ?? 0

    return result
}

let sortedRoutes = routes.map({ ($0, cost(route: $0)) }).sorted { (left, right) -> Bool in
    left.1 < right.1
}

print(sortedRoutes.first)
print(sortedRoutes[sortedRoutes.count - 1])
