//: [Previous](@previous)

import Foundation

let str = "Hello, playground"

func doCount(input: String) -> (Int, Int) {
    var code = 0
    var data = 0
    var gen = input.characters.generate()
    while let next = gen.next() {
        switch next {
        case " ", "\n":
            continue
        case "\"":
            code++
        case "\\":
            code++; data++
            let after = gen.next()!
            switch after {
                case "\\", "\"":
                    code++
                break
                case "x":
                gen.next()
                gen.next()
                code += 3
            default:
                break
            }
        default:
            code++; data++
        }
    }
    return (code, data)
}

print(doCount(str))

let testString = String(data: NSData(contentsOfURL:[#FileReference(fileReferenceLiteral: "test.txt")#])!, encoding: NSUTF8StringEncoding)!
print(doCount(testString))

let inputString = String(data: NSData(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#] )!, encoding: NSUTF8StringEncoding)!

let result = doCount(inputString)

print(result.0 - result.1)

let testStrings = testString.characters.split("\n").map { String($0) }
print(testStrings)

func reEncode(input: String) -> (Int, Int) {
    var gen = input.characters.generate()
    var code = 2 //includes closing quotes
    var data = 0
    while let next = gen.next() {
        switch next {
        case "\"", "\\":
            data += 1
            code += 2
        default:
            code++; data++
        }
    }

    return (code, data)
}

for test in testStrings {
    let result = reEncode(test)
    print("\(test): \(result)")
}

let results = testStrings.map { reEncode($0) }
let differences = results.map { $0 - $1 }
let answer = differences.reduce(0, combine: +)
print(answer)

let inputStrings = inputString.characters.split("\n").map { String($0) }

let final = inputStrings.map { reEncode($0) }.map { $0 - $1 }.reduce(0, combine: +)
print(final)

//: [Next](@next)
