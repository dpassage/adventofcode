//: [Previous](@previous)

import Foundation
import AdventLib

guard CommandLine.arguments.count > 1 else { exit(1) }

struct Password: CustomStringConvertible {
    var value: UInt64

    init(value: UInt64) {
        self.value = value
    }

    init?(input: String) {

        let scalars = input.unicodeScalars
        guard scalars.count <= 8 else { return nil }
        self.value = scalars.map { $0.value }.map { $0 - 97 }.reduce(0) { (sum: UInt64, next: UInt32) -> UInt64 in
            return (sum * UInt64(26)) + UInt64(next)
        }
    }

    var description: String {
        return text
    }

    var text: String {
        var result: String.UnicodeScalarView = String.UnicodeScalarView()

        var numbers = [UInt64](repeating: 0, count: 8)

        var remainder = value
        for i in 0 ... 7 {
            numbers[i] = remainder % 26
            remainder /= 26
        }
        for i in [7, 6, 5, 4, 3, 2, 1, 0] {
            result.append(UnicodeScalar(UInt32(numbers[i] + 97))!)
        }

        return String(result)
    }

    func next() -> Password {
        return Password(value: self.value + 1)
    }
}

func threeLetterStraight(input: String) -> Bool {
    let chars = [UnicodeScalar](input.unicodeScalars)
    let length = chars.count
    guard length >= 3 else { return false }

    for i in 0 ..< length - 2 {
        if chars[i].value + 1 == chars[i + 1].value &&
            chars[i + 1].value + 1 == chars[i + 2].value {
            return true
        }
    }
    return false
}

func noIOorL(input: String) -> Bool {
    for char in input {
        guard char != "i" else { return false }
        guard char != "o" else { return false }
        guard char != "l" else { return false }
    }
    return true
}

func hasTwoPairs(input: String) -> Bool {
    let regex = try! Regex(pattern: "^.*([a-z])\\1{1}.*([a-z])\\2{1}.*$")
    if regex.match(input: input) != nil {
        return true
    }
    return false
}
func validPassword(input: String) -> Bool {
    return threeLetterStraight(input: input) && noIOorL(input: input) && hasTwoPairs(input: input)
}

var input = CommandLine.arguments[1]

var password = Password(input: input)!
while !validPassword(input: password.description) {
    password = password.next()
}
print("next password is: \(password)")
//: [Next](@next)
