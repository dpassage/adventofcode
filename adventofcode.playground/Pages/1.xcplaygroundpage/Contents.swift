import Foundation

func santa(input: String) -> Int {
    var answer: Int = 0

    for char in input.characters {
        switch char {
        case "(":
            answer += 1
        case ")":
            answer -= 1
        default:
            break
        }
    }
    return answer
}

let inputFile = [#FileReference(fileReferenceLiteral: "input.txt")#]

let inputData = NSData(contentsOfURL: inputFile)!

let inputString = String(data: inputData, encoding: NSUTF8StringEncoding)!

print(santa(inputString))

func basement(input: String) -> Int {
    var answer: Int = 0
    var count: Int = 0

    for char in input.characters {
        switch char {
            case "(":
            answer += 1
            count += 1
            case ")":
            answer -= 1
            count += 1
        default:
            break
        }
        if answer == -1 {
            break
        }
    }

    return count
}

print(basement(inputString))
