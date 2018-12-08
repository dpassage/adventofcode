import Foundation

func successor(code: Int) -> Int {
    let product = code * 252533
    let remainder = product % 33554393
    return remainder
}

print(successor(code: 20151125))

func ordinalOfCoordinates(row targetRow: Int, column targetColumn: Int) -> Int {
    var currentResult = 1
    var currentRow = 1
    var currentColumn = 1
    while !(currentRow == targetRow && currentColumn == targetColumn) {
        currentResult += 1
        if currentRow == 1 {
            currentRow = currentColumn + 1
            currentColumn = 1
        } else {
            currentRow -= 1
            currentColumn += 1
        }
    }
    return currentResult
}

print(ordinalOfCoordinates(row: 1, column: 1))
print(ordinalOfCoordinates(row: 2, column: 1))
print(ordinalOfCoordinates(row: 1, column: 2))
print(ordinalOfCoordinates(row: 4, column: 3))

let targetOrdinal = ordinalOfCoordinates(row: 2978, column: 3083)
print(targetOrdinal)

func codeForOrdintal(start: Int, ordinal: Int) -> Int {
    var result = start
    for _ in 1..<ordinal {
        result = successor(code: result)
    }
    return result
}

print(codeForOrdintal(start: 20151125, ordinal: 3))

print(codeForOrdintal(start: 20151125, ordinal: targetOrdinal))

