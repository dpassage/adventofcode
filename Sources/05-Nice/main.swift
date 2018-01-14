//: [Previous](@previous)

import Foundation
import AdventLib

func threeVowels(string: String) -> Bool {
    return string.characters.filter { "aeiou".characters.contains($0) }.count >= 3
}

func repeatedLetter(string: String) -> Bool {
    let chars = string.characters
    var prev: Character = "!".characters.first!

    for char in chars {
        if char == prev { return true }
        prev = char
    }
    return false
}

func containsBadStrings(string: String) -> Bool {
    let badStrings = ["ab", "cd", "pq", "xy"]

    for badString in badStrings {
        if string.contains(badString) { return true }
    }

    return false
}

func nice(string: String) -> Bool {
    return threeVowels(string: string) && repeatedLetter(string: string) && !containsBadStrings(string: string)
}

func containsRepeatedPair(string: String) -> Bool {

    var remainingCharacters = string.characters
    while remainingCharacters.count >= 4 {
        let prefix = String(remainingCharacters.prefix(2))
        let suffix = String(remainingCharacters.dropFirst(2))
        if suffix.contains(prefix) { return true }
        remainingCharacters = remainingCharacters.dropFirst(1)
    }

    return false
}

func containsRepeatedOneLetterBetween(string: String) -> Bool {
    let characters = Array(string.characters)
    guard characters.count >= 3 else { return false }

    for index in 0 ..< (characters.count - 2) {
        if characters[index] == characters[index + 2] { return true }
    }
    return false
}

func reallyNice(string: String) -> Bool {
    return containsRepeatedOneLetterBetween(string: string) && containsRepeatedPair(string: string)
}

let inputStrings = TextFile.standardInput().readLines()

print(inputStrings.filter { nice(string: $0) }.count)
print(inputStrings.filter { reallyNice(string: $0) }.count)
