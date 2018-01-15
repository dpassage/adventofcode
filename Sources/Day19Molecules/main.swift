import Foundation
import AdventLib

struct Rule {
    let left: String
    let right: String

    init(left: String, right: String) {
        self.left = left
        self.right = right
    }

    init?(string: String) {
        let regex = try! Regex(pattern: "^([a-zA-Z]+) => ([a-zA-Z]+)$")

        guard let matches = regex.match(input: string),
            matches.count == 2 else { return nil }

        self.init(left: matches[0], right: matches[1])
    }
}

func applyRule(rule: Rule, input: String) -> [String] {

    let split = input.components(separatedBy: rule.left)
    var results = [String]()

    for i in 0 ..< split.count - 1 {
        let leftSplit = split[0 ... i]
        let rightSplit = split[i + 1 ..< split.count]

        let leftPart = leftSplit.joined(separator: rule.left)
        let rightPart = rightSplit.joined(separator: rule.left)

        let result = [leftPart, rightPart].joined(separator: rule.right)

        results.append(result)
    }

    return results
}

func reverseApply(rule: Rule, input: String) -> [String] {
    let split = input.components(separatedBy: rule.right)
    var results = [String]()

    let separator = (rule.left == "e") ? "" : rule.left

    for i in 0 ..< split.count - 1 {
        let leftSplit = split[0 ... i]
        let rightSplit = split[i + 1 ..< split.count]

        let leftPart = leftSplit.joined(separator: rule.right)
        let rightPart = rightSplit.joined(separator: rule.right)

        let result = [leftPart, rightPart].joined(separator: separator)

        results.append(result)
    }

    return results
}

func computeStrings(input: String, rules: [Rule]) -> Set<String> {
    let mapresults = rules.map { (rule) -> [String] in
        return applyRule(rule: rule, input: input)
    }

    let finalSet = mapresults.reduce(Set<String>()) { (resultSet, arrayOfStrings) -> Set<String> in
        return resultSet.union(arrayOfStrings)
    }

    return finalSet
}

func reverseCompute(input: String, rules: [Rule]) -> Set<String> {
    let mapresults = rules.map { (rule) -> [String] in
        return reverseApply(rule: rule, input: input)
    }

    let finalSet = mapresults.reduce(Set<String>()) { (resultSet, arrayOfStrings) -> Set<String> in
        return resultSet.union(arrayOfStrings)
    }

    return finalSet
}

var inputRules = [Rule]()
var target: String = ""
// day 1
let file: TextFile
if CommandLine.arguments.count >= 2 {
    guard let theFile = TextFile(fileName: CommandLine.arguments[1]) else {
        print("file not found: \(CommandLine.arguments[1])")
        exit(1)
    }
    file = theFile
} else {
    file = TextFile.standardInput()
}
for line in file.readLines() {

    guard !line.isEmpty else { break }

    if let rule = Rule(string: line) {
        inputRules.append(rule)
    } else {
        target = line
        let result = computeStrings(input: line, rules: inputRules)
        print(result)
        print(result.count)
    }
}

// it's BFS time!
struct Step {
    var soFar: Int
    var current: String

    var score: Int { return soFar + current.count }
}

func findShortestPath() -> Int {
    let start = Step(soFar: 0, current: target)
    var visited: Set<String> = [target]
    var heap = Heap<Step> { (left, right) -> Bool in
        return left.score < right.score
    }
    heap.enqueue(start)

    while let next = heap.dequeue() {
        if next.current == "" { return next.soFar }
        print(heap.count)
        visited.insert(next.current)
        let nextStrings = reverseCompute(input: next.current, rules: inputRules)
        for nextString in nextStrings {
            if visited.contains(nextString) { continue }
            heap.enqueue(Step(soFar: next.soFar + 1, current: nextString))
        }
    }
    return -1
}

print("shortest path: ", findShortestPath())
