//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


struct Light {
    var x: Int
    var y: Int
}

struct Rectangle {
    var start: Light
    var finish: Light
}

enum CommandMode: String {
    case On = "on"
    case Off = "off"
    case Toggle = "toggle"
}

struct Command {
    var rectangle: Rectangle
    var mode: CommandMode
    init?(commandString: String) {

        let regex = try! NSRegularExpression(pattern: ".*(on|off|toggle)\\D*(\\d+)\\D*(\\d+)\\D*(\\d+)\\D*(\\d+)", options: [])
        let command = commandString as NSString
        guard let match = regex.matchesInString(commandString, options: [], range: NSRange(location: 0, length: command.length)).first else { return nil }

        let mode = command.substringWithRange(match.rangeAtIndex(1))
        let firstX = Int(command.substringWithRange(match.rangeAtIndex(2)))!
        let firstY = Int(command.substringWithRange(match.rangeAtIndex(3)))!
        let endX = Int(command.substringWithRange(match.rangeAtIndex(4)))!
        let endY = Int(command.substringWithRange(match.rangeAtIndex(5)))!

        rectangle = Rectangle(start: Light(x: firstX, y: firstY), finish: Light(x: endX, y: endY))
        guard let theMode = CommandMode(rawValue: mode) else { return nil }
        self.mode = theMode
    }


}

let input = [#FileReference(fileReferenceLiteral: "commands.txt")#]

let inputData = NSData(contentsOfURL: input)!

let inputString = String(data: inputData, encoding: NSUTF8StringEncoding)!

let commandStrings = inputString.characters.split("\n").map { String($0) }

let commands = commandStrings.map({ Command(commandString: $0) })

//let commands = [Command(commandString: "turn on 0,0 through 999,999")!,
//Command(commandString: "toggle 0,0 through 999,0")!,
//Command(commandString: "turn off 499,499 through 500,500")!]
//let commands = [Command]()



var lights = [Bool](count: 1000 * 1000, repeatedValue: false)


for command in commands {
    guard let command = command else { continue }
    for x in command.rectangle.start.x...command.rectangle.finish.x {
        for y in command.rectangle.start.y...command.rectangle.finish.y {
            let i = x * 1000 + y
            switch command.mode {
            case .On:
                lights[i] = true
            case .Off:
                lights[i] = false
            case .Toggle:
                lights[i] = !lights[i]
            }
        }
    }
}

let result = lights.filter({ $0 }).count
print(result)



//: [Next](@next)
