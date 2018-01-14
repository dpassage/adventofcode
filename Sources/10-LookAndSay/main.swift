import Foundation

guard CommandLine.arguments.count == 3 else { exit(1) }

var theString = CommandLine.arguments[1]
let iterations = Int(CommandLine.arguments[2])!

func lookAndSay(input: String) -> String {
    let inputWithSentinel = "\(input)Q"
    let chars = inputWithSentinel.characters

    var result = ""
    var last: Character = "Q"
    var count = 0

    for char in chars {
        if char == last {
            count += 1
        } else {
            if last != "Q" {
                result.append("\(count)\(last)")
            }
            last = char
            count = 1
        }
    }

    return result
}

for i in 0 ..< iterations {
    theString = lookAndSay(input: theString)
}

print(theString.characters.count)
