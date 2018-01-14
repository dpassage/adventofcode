// swift-tools-version:4.0
import PackageDescription

let targetNames = [
    "Day01Floors",
    "02-Presents",
    "03-Visits",
    "05-Nice",
    "06-Lights",
    "07-Wires",
    "08-Matchsticks",
    "09-Routes",
    "11-Passwords",
    "13-Seating",
    "14-Reindeer",
    "15-Cookie",
    "16-Sues",
    "17-Eggnog",
    "18-GIF",
    "Day19Molecules",
    "Day20Elves"
]

let targets: [Target] = targetNames.map { name -> Target in
    return Target.target(
        name: name,
        dependencies: [.target(name: "AdventLib")]
    )
}

let allTargets = targets + [Target.target(name: "AdventLib")]

let package = Package(name: "AdventOfCode",
                      targets: allTargets)
