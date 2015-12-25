//: [Previous](@previous)

import Foundation


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

        var numbers = Array<UInt64>(count: 8, repeatedValue: 0)

        var remainder = value
        for i in 0...7 {
            numbers[i] = remainder % 26
            remainder = remainder / 26
        }
        for i in [7,6,5,4,3,2,1,0] {
            result.append(UnicodeScalar(UInt32(numbers[i] + 97)))
        }

        return String(result)
    }

    func next() -> Password {
        return Password(value: self.value + 1)
    }
}

let whee = Password(value: 1)
print(whee.text)
whee.next()
whee.next()

func threeLetterStraight(input: String) -> Bool {
    let chars = Array<UnicodeScalar>(input.unicodeScalars)
    let length = chars.count
    guard length >= 3 else { return false }

    for i in 0..<length - 2 {
        if chars[i].value + 1 == chars[i+1].value &&
            chars[i+1].value + 1 == chars[i+2].value  {
                return true
        }
    }
    return false
}

threeLetterStraight(whee.description)
threeLetterStraight("abcd")

func noIOorL(input: String) -> Bool {
    for char in input.characters {
        guard char != "i" else { return false }
        guard char != "o" else { return false }
        guard char != "l" else { return false }
    }
    return true
}

noIOorL("abbceffg")

func hasTwoPairs(input: String) -> Bool {

    return false
}

//: [Next](@next)
