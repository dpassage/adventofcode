import Foundation


struct LifeGrid {
    private var backingStore: Array<Bool>
    var rows: Int
    var columns: Int

    init(rows: Int, columns: Int, repeatedValue: Bool) {
        backingStore = Array<Bool>(count: rows * columns, repeatedValue: repeatedValue)
        self.rows = rows
        self.columns = columns
    }

    // init(rows: Int, columns: Int, grid: String) {
    //     init(rows, columns, repeatedValue: false)
    //
    //     var row = 0
    //     var column = 0
    //
    //
    // }

    private func toIndex(row row: Int, column: Int) -> Int {
        return (row * columns) + column
    }

    private func validCoords(row row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Bool {
        get {
            return validCoords(row: row, column: column) && backingStore[toIndex(row: row, column: column)]
        }
        set(newValue) {
            guard validCoords(row: row, column: column) else { return }
            backingStore[toIndex(row: row, column: column)] = newValue
        }
    }
}

extension LifeGrid: CustomStringConvertible {

    func score(row row: Int, column: Int) -> Int {

        let indexDeltas = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]

        let result = indexDeltas
                .map { (row + $0.0, column + $0.1) }
                .map { self[$0.0, $0.1] }
                .map { $0 ? 1 : 0 }
                .reduce(0, combine: +)

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
                result.appendContentsOf(cell)
            }
            result.appendContentsOf("\n")
        }
        return result
    }

    func totalLights() -> Int {
        return backingStore.map { $0 ? 1 : 0 }.reduce(0, combine: +)
    }
}

let start = LifeGrid(rows: 5, columns: 5, repeatedValue: true)
print(start.totalLights())
let next = start.runLife()

print(next)
print(next.totalLights())
