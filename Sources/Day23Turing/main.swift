import Foundation

enum Reg: String {
    case a
    case b
}
enum Instr {
    case hlf(Reg)
    case tpl(Reg)
    case inc(Reg)
    case jmp(Int)
    case jie(Reg, Int)
    case jio(Reg, Int)

    // swiftlint:disable cyclomatic_complexity
    init?(s: String) {
        let parts = s.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
        guard parts.count > 0 else { return nil }

        switch parts[0] {
        case "hlf":
            guard let reg = Reg(rawValue: String(parts[1])) else { return nil }
            self = .hlf(reg)
        case "tpl":
            guard let reg = Reg(rawValue: String(parts[1])) else { return nil }
            self = .tpl(reg)
        case "inc":
            guard let reg = Reg(rawValue: String(parts[1])) else { return nil }
            self = .inc(reg)
        case "jmp":
            guard let offset = Int(parts[1]) else { return nil }
            self = .jmp(offset)
        case "jie":
            let operands = parts[1].components(separatedBy: ", ")
            guard let reg = Reg(rawValue: operands[0]) else { return nil }
            guard let offset = Int(operands[1]) else { return nil }
            self = .jie(reg, offset)
        case "jio":
            let operands = parts[1].components(separatedBy: ", ")
            guard let reg = Reg(rawValue: operands[0]) else { return nil }
            guard let offset = Int(operands[1]) else { return nil }
            self = .jio(reg, offset)
        default:
            return nil
        }
    }
}

struct Registers<R: Hashable> {
    private var storage: [R: Int] = [:]

    subscript(reg: R) -> Int {
        get {
            return storage[reg] ?? 0
        }
        set {
            storage[reg] = newValue
        }
    }
}

class Machine {
    var registers = Registers<Reg>()
    var ip = 0

    var instructions: [Instr]

    init(program: String) {
        instructions = program.split(separator: "\n")
                            .map(String.init)
                            .compactMap(Instr.init)
    }

    func reset() {
        registers = Registers<Reg>()
        ip = 0
    }

    func run() {
        while instructions.indices.contains(ip) {
            let instr = instructions[ip]
            print("\(ip) \(instr)")
            switch instr {
            case let .hlf(reg):
                registers[reg] /= 2
                ip += 1
            case let .tpl(reg):
                registers[reg] *= 3
                ip += 1
            case let .inc(reg):
                registers[reg] += 1
                ip += 1
            case let .jmp(offset):
                ip += offset
            case let .jie(reg, offset):
                if registers[reg] % 2 == 0 {
                    ip += offset
                } else {
                    ip += 1
                }
            case let .jio(reg, offset):
                ip += (registers[reg] == 1) ? offset : 1
            }
        }
        print(registers)
    }
}

let program = """
jio a, +19
inc a
tpl a
inc a
tpl a
inc a
tpl a
tpl a
inc a
inc a
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
jmp +23
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
inc a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7
"""

let machine = Machine(program: program)
machine.run()

machine.reset()
machine.registers[.a] = 1
machine.run()
