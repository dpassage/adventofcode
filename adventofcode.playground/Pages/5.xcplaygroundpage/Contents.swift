//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

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
        if string.containsString(badString) { return true }
    }

    return false
}

func nice(string: String) -> Bool {
    return threeVowels(string) && repeatedLetter(string) && !containsBadStrings(string)
}

nice("ugknbfddgicrmopn")
nice("aaa")
nice("jchzalrnumimnmhp")
nice("haegwjzuvuyypxyu")
nice("dvszwmarrgswjxmb")

let input = [#FileReference(fileReferenceLiteral: "input.txt")#]

let inputData = NSData(contentsOfURL: input)!

let inputString = String(data: inputData, encoding: NSUTF8StringEncoding)!

let inputStrings = inputString.characters.split("\n").map { String($0) }

//print(inputStrings.filter { nice($0) }.count)

func containsRepeatedPair(string: String) -> Bool {

    var remainingCharacters = string.characters
    while remainingCharacters.count >= 4 {
        let prefix = String(remainingCharacters.prefix(2))
        let suffix = String(remainingCharacters.dropFirst(2))
        if suffix.containsString(prefix) { return true }
        remainingCharacters = remainingCharacters.dropFirst(1)
    }

    return false
}

containsRepeatedPair("xyxy")
containsRepeatedPair("aabcdefgaaasdfsafd")
containsRepeatedPair("aaab")

func containsRepeatedOneLetterBetween(string: String) -> Bool {
    let characters = Array(string.characters)
    guard characters.count >= 3 else { return false }

    for index in 0..<(characters.count - 2) {
        if characters[index] == characters[index + 2] { return true }
    }
    return false
}

//containsRepeatedOneLetterBetween("xyx")
//containsRepeatedOneLetterBetween("abcdefeghi")
containsRepeatedOneLetterBetween("aaa")
containsRepeatedOneLetterBetween("uurcxstgmygtbstg")

func reallyNice(string: String) -> Bool {
    return containsRepeatedOneLetterBetween(string) && containsRepeatedPair(string)
}

reallyNice("qjhvhtzxzqqjkmpb")
reallyNice("xxyxx")
reallyNice("uurcxstgmygtbstg")
reallyNice("ieodomkazucvgmuy")
//
print(inputStrings.filter { reallyNice($0) }.count)


//: [Next](@next)
