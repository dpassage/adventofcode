import Foundation

guard Process.arguments.count == 3 else { exit(1) }

var theString = Process.arguments[1]
let iterations = Int(Process.arguments[2])!

func lookAndSay(input: String) -> String {
    let inputWithSentinel = "\(input)Q"
    let chars = inputWithSentinel.characters

    var result = ""
    var last: Character = "Q"
    var count = 0

    for char in chars {
        if char == last {
            count++
        } else {
            if last != "Q" {
                result.appendContentsOf("\(count)\(last)")
            }
            last = char
            count = 1
        }
    }

    return result
}

for i in 0..<iterations {
    theString = lookAndSay(theString)
}

print(theString.characters.count)
