import Foundation
import AdventLib

struct Light {
    var x: Int
    var y: Int
}

struct Rectangle {
    var start: Light
    var finish: Light
}

// swiftlint:disable type_name
enum CommandMode: String {
    case On = "on"
    case Off = "off"
    case Toggle = "toggle"
}
// swiftlint:enable type_name

struct Command {
    var rectangle: Rectangle
    var mode: CommandMode
    init?(commandString: String) {

        let regex = try! NSRegularExpression(pattern:
	    ".*(on|off|toggle)\\D*(\\d+)\\D*(\\d+)\\D*(\\d+)\\D*(\\d+)", options: [])
        let command = commandString as NSString
        guard let match = regex.matchesInString(commandString, options: [],
	      range: NSRange(location: 0, length: command.length)).first else { return nil }

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

let commandStrings = TextFile.standardInput().readLines()

let commands = commandStrings.map { Command(commandString: $0) }

var lights = [Int](count: 1000 * 1000, repeatedValue: 0)
for command in commands {
    guard let command = command else { continue }
    for x in command.rectangle.start.x...command.rectangle.finish.x {
        for y in command.rectangle.start.y...command.rectangle.finish.y {
            let i = x * 1000 + y
            switch command.mode {
            case .On:
                lights[i] += 1
            case .Off:
                if lights[i] > 0 {
                    lights[i] -= 1
                }
            case .Toggle:
                lights[i] += 2
            }
        }
    }
}

let result = lights.reduce(0, combine: +)
print(result)
