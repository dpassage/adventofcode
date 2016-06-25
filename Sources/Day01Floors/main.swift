import AdventLib

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

let inputString = TextFile.standardInput().readString()

if Process.arguments[1] == "--basement" {
    print(basement(input: inputString))
} else {
    print(santa(input: inputString))
}
