//: Playground - noun: a place where people can play

import Foundation
import AdventLib

guard Process.arguments.count >= 2 else { exit(1) }
guard let timespan = Int(Process.arguments[1]) else { exit (1) }

struct Reindeer {
    var speed: Int
    var duration: Int
    var rest: Int

    func distanceTraveledIn(seconds: Int) -> Int {
        let cycle = duration + rest
        let cycles = seconds / cycle
        let remainder = seconds % cycle

        let cycleDistance = cycles * duration * speed

        let remainderDistance = min(duration, remainder) * speed
        return cycleDistance + remainderDistance
    }
}

let regex = try! Regex(pattern: "^([a-zA-Z]+) can fly (\\d+) km/s for (\\d+) seconds, but then must rest for (\\d+) seconds.")

let inputStrings = TextFile.standardInput().readLines()

var reindeer = [String: Reindeer]()

for input in inputStrings {
    guard let match = regex.match(input) else { continue }
    guard match.count == 4 else { continue }

    let name = match[0]
    let speed = Int(match[1])!
    let duration = Int(match[2])!
    let rest = Int(match[3])!

    reindeer[name] = Reindeer(speed: speed, duration: duration, rest: rest)
}

for (name, value) in reindeer {
    let result = value.distanceTraveledIn(timespan)
    print("\(name): \(result)")
}

var points = [String: Int]()

for i in 1...timespan {
    let results = reindeer.map { (name, deer) -> (String, Int) in
        return (name, deer.distanceTraveledIn(i))
    }
    .sort { (left, right) -> Bool in
        left.1 > right.1
    }

    let winningScore = results.first!.1

    let winners = results.filter { (name, score) -> Bool in
        score == winningScore
    }

    for winner in winners {
        points[winner.0] = (points[winner.0] ?? 0) + 1
    }
}

for (name, value) in points {
    print("\(name): \(value)")
}
