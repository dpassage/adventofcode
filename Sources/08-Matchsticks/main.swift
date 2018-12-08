//: [Previous](@previous)

import Foundation
import AdventLib

func doCount(input: String) -> (Int, Int) {
    var code = 0
    var data = 0
    var gen = input.makeIterator()
    while let next = gen.next() {
        switch next {
        case " ", "\n":
            continue
        case "\"":
            code += 1
        case "\\":
            code += 1
            data += 1
            let after = gen.next()!
            switch after {
            case "\\", "\"":
                code += 1
            case "x":
                _ = gen.next()
                _ = gen.next()
                code += 3
            default:
                break
            }
        default:
            code += 1
            data += 1
        }
    }
    return (code, data)
}

func reEncode(input: String) -> (Int, Int) {
    var gen = input.makeIterator()
    var code = 2 // includes closing quotes
    var data = 0
    while let next = gen.next() {
        switch next {
        case "\"", "\\":
            data += 1
            code += 2
        default:
            code += 1
            data += 1
        }
    }

    return (code, data)
}

let inputStrings = TextFile.standardInput().readLines()
let result = inputStrings
    .map { doCount(input: $0) }
    .map { $0.0 - $0.1 }.reduce(0, +)

print("doCount: \(result)")

let nextResult = inputStrings
    .map { reEncode(input: $0) }
    .map { $0 - $1 }
    .reduce(0, +)

print("reEncode: \(nextResult)")

// for test in testStrings {
//     let result = reEncode(test)
//     print("\(test): \(result)")
// }
//
// let results = testStrings.map { reEncode($0) }
// let differences = results.map { $0 - $1 }
// let answer = differences.reduce(0, combine: +)
// print(answer)
//
// let inputStrings = inputString.characters.split("\n").map { String($0) }
//
// let final = inputStrings.map { reEncode($0) }.map { $0 - $1 }.reduce(0, combine: +)
// print(final)

//: [Next](@next)
