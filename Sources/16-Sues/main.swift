import AdventLib

typealias Sue = [String: Int]

var sues = [Int: Sue]()

let inputStrings = TextFile.standardInput().readLines()

for inputString in inputStrings {
    print(inputString)
    let regex = try! Regex(pattern: "^Sue ([0-9]+): (.*)$")
    guard let match = regex.match(inputString) else { continue }

    let sueIndex = Int(match[0])!
    var sueProperties = [String: Int]()

    // print("sueIndex: \(sueIndex) properties: \(match[1])")

    let propertyStrings = match[1].componentsSeparatedByString(", ")

    for propString in propertyStrings {
        let parts = propString.componentsSeparatedByString(": ")
        guard parts.count == 2 else { continue }

        // print("parts: \(parts)")
        sueProperties[parts[0]] = Int(parts[1])!
    }

    sues[sueIndex] = sueProperties
}

print(sues)

let targetSue = [
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
]

nextSue: for (index, sue) in sues {
    for (name, value) in sue {
        if value != targetSue[name] {
            continue nextSue
        }
    }
    print("MATCH: \(index) \(sue)")
}
