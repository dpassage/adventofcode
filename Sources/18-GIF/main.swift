import Foundation
import AdventLib

struct LifeGrid {
    private var backingStore: Array<Bool>
    var rows: Int
    var columns: Int

    init(rows: Int, columns: Int, repeatedValue: Bool) {
        backingStore = Array<Bool>(repeating: repeatedValue, count: rows * columns)
        self.rows = rows
        self.columns = columns
    }

    init(rows: Int, columns: Int, grid: String) {
        self.init(rows: rows, columns: columns, repeatedValue: false)

        var row = 0
        var column = 0

        for char in grid.characters {
            switch char {
            case "#":
                self[row, column] = true
                column += 1
            case ".":
                self[row, column] = false
                column += 1
            case "\n":
                row += 1
                column = 0
            default:
                break
            }
        }
    }

    private func toIndex(row: Int, column: Int) -> Int {
        return (row * columns) + column
    }

    private func validCoords(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    private func corner(row: Int, column: Int) -> Bool {
        switch (row, column) {
            case (0,0): return true
            case (0, columns - 1): return true
            case (rows - 1, 0): return true
            case (rows - 1, columns - 1): return true
            default: return false
        }
    }

    subscript(row: Int, column: Int) -> Bool {
        get {
            if corner(row: row, column: column) { return true }
            return validCoords(row: row, column: column) && backingStore[toIndex(row: row, column: column)]
        }
        set(newValue) {
            guard validCoords(row: row, column: column) else { return }
            backingStore[toIndex(row: row, column: column)] = newValue
        }
    }
}

extension LifeGrid: CustomStringConvertible {

    func score(row: Int, column: Int) -> Int {

        let indexDeltas = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]

        let result = indexDeltas
                .map { (row + $0.0, column + $0.1) }
                .map { self[$0.0, $0.1] }
                .map { $0 ? 1 : 0 }
                .reduce(0, +)

        return result
    }

    func runLife() -> LifeGrid {
        var new = LifeGrid(rows: rows, columns: columns, repeatedValue: false)

        for row in 0..<rows {
            for column in 0..<columns {
                let thisScore = score(row: row, column: column)
                if self[row, column],
                   case 2...3 = thisScore {
                    new[row, column] = true
                } else {
                    new[row, column] = score(row: row, column: column) == 3
                }
            }
        }
        return new
    }

    var description: String {
        var result = ""
        for row in 0..<rows {
            for column in 0..<columns {
                let cell = self[row, column] ? "#" : "."
                result.append(cell)
            }
            result.append("\n")
        }
        return result
    }

    func totalLights() -> Int {
        var result = 0

        for row in 0..<rows {
            for column in 0..<columns {
                result += self[row, column] ? 1 : 0
            }
        }
        return result
    }
}

guard CommandLine.arguments.count > 3 else {
    print("specifiy a size and count")
    exit(1)
}

guard let rows = Int(CommandLine.arguments[1]),
    let columns = Int(CommandLine.arguments[2]),
    let count = Int(CommandLine.arguments[3]) else {
    print("specify a size and count")
    exit(1)
}

let gridString = TextFile.standardInput().readString()

var start = LifeGrid(rows: rows, columns: columns, grid: gridString)

print(start.totalLights())

for _ in 0..<count {
    let next = start.runLife()

    print(next)
    print(next.totalLights())
    start = next
}
