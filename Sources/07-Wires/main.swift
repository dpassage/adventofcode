//: [Previous](@previous)

import Foundation
import AdventLib

if CommandLine.arguments.count < 2 {
    print("must give target wire name")
    exit(1)
}

let target = CommandLine.arguments[1]

// swiftlint:disable type_name
enum GateValue {
    case Value(UInt16)
    case Wire(String)
    case And(String, String)
    case Or(String, String)
    case Not(String)
    case Lshift(String, UInt16)
    case Rshift(String, UInt16)
    case AndOne(String)
}
// swiftlint:enable type_name

func parseAsValue(input: String) -> (GateValue)? {
    let regex = try! AdventLib.Regex(pattern: "^(\\d+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 1 else { return nil }

    let value = UInt16(match[0])!

    return (GateValue.Value(value))
}

func parseAsAnd(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^([a-z]+) AND ([a-z]+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 2 else { return nil }

    let left = match[0]
    let right = match[1]

    return (GateValue.And(left, right))
}
func parseAsAndOne(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^1 AND ([a-z]+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 1 else { return nil }

    let left = match[0]

    return (GateValue.AndOne(left))
}

func parseAsOr(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^([a-z]+) OR ([a-z]+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 2 else { return nil }

    let left = match[0]
    let right = match[1]

    return (GateValue.Or(left, right))
}

func parseAsLShift(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^([a-z]+) LSHIFT (\\d+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 2 else { return nil }

    let left = match[0]
    guard let right = UInt16(match[1]) else { return nil }

    return (GateValue.Lshift(left, right))
}

func parseAsRShift(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^([a-z]+) RSHIFT (\\d+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 2 else { return nil }

    let left = match[0]
    guard let right = UInt16(match[1]) else { return nil }

    return (GateValue.Rshift(left, right))
}

func parseAsNot(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^NOT ([a-z]+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 1 else { return nil }

    return (GateValue.Not(match[0]))
}

func parseAsWire(input: String) -> (GateValue)? {
    let regex = try! Regex(pattern: "^([a-z]+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 1 else { return nil }

    return (GateValue.Wire(match[0]))
}

func parseCommand(input: String) -> (GateValue, String)? {
    let regex = try! Regex(pattern: "^(.+) -> ([a-z]+)$")
    guard let match = regex.match(input: input) else { return nil }
    guard match.count == 2 else { return nil }

    let signal = match[0]
    let name = match[1]

    if let value = parseAsValue(input: signal) {
        return (value, name)
    } else if let andValue = parseAsAnd(input: signal) {
        return (andValue, name)
    } else if let orValue = parseAsOr(input: signal) {
        return (orValue, name)
    } else if let lShift = parseAsLShift(input: signal) {
        return (lShift, name)
    } else if let rShift = parseAsRShift(input: signal) {
        return (rShift, name)
    } else if let notValue = parseAsNot(input: signal) {
        return (notValue, name)
    } else if let wireValue = parseAsWire(input: signal) {
        return (wireValue, name)
    } else if let wireValue = parseAsAndOne(input: signal) {
        return (wireValue, name)
    }

    return nil
}


var commands = [String: GateValue]()

let commandStrings = TextFile.standardInput().readLines()

for commandString in commandStrings {
    if let (value, name) = parseCommand(input: commandString) {
        commands[name] = value
    }
}

print(commands)

enum InterpreterErrors: Error {
    case Ack
}

var memo = [String: UInt16]()

func interpret(commands: [String: GateValue], wire: String) throws -> UInt16 {
    print("interpret: \(wire)")
    if let value = memo[wire] { return value }
    guard let value = commands[wire] else { throw InterpreterErrors.Ack }

    switch value {
    case let .Value(num):
        memo[wire] = num
        return num
    case let .Wire(name):
        let result = try! interpret(commands: commands, wire: name)
        memo[wire] = result
        return result
    case let .And(l, r):
        let result = (try! interpret(commands: commands, wire: l)) & (try! interpret(commands: commands, wire: r))
        memo[wire] = result
        return result
    case let .Or(l, r):
        let result = (try! interpret(commands: commands, wire: l)) | (try! interpret(commands: commands, wire: r))
        memo[wire] = result
        return result
    case let .Not(name):
        let result = ~(try! interpret(commands: commands, wire: name))
        memo[wire] = result
        return result
    case let .Lshift(name, bits):
        let result = (try! interpret(commands: commands, wire: name)) << bits
        memo[wire] = result
        return result
    case let .Rshift(name, bits):
        let result = (try! interpret(commands: commands, wire: name)) >> bits
        memo[wire] = result
        return result
    case let .AndOne(name):
        let result = (try! interpret(commands: commands, wire: name)) & 1
        memo[wire] = result
        return result
    }
}

let answer = try! interpret(commands: commands, wire: target)
print("\(target): \(answer)")
