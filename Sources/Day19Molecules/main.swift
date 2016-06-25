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

        guard let matches = regex.match(input: string) where
            matches.count == 2 else { return nil }

        self.init(left: matches[0], right: matches[1])
    }
}

func applyRule(rule: Rule, input: String) -> [String] {

    let split = input.components(separatedBy: rule.left)
    var results = [String]()

    for i in 0..<split.count-1 {
        let leftSplit = split[0...i]
        let rightSplit = split[i+1..<split.count]

        let leftPart = leftSplit.joined(separator: rule.left)
        let rightPart = rightSplit.joined(separator: rule.left)

        let result = [leftPart, rightPart].joined(separator: rule.right)

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

var inputRules = [Rule]()

for line in TextFile.standardInput().readLines() {

    guard !line.isEmpty else { break }

    if let rule = Rule(string: line) {
        inputRules.append(rule)
    } else {
        let result = computeStrings(input: line, rules: inputRules)
        print(result)
        print(result.count)
    }
}
