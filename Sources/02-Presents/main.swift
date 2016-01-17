import Foundation

import AdventLib

struct Present {
    let length: Int
    let width: Int
    let height: Int

    func paperNeeded() -> Int {
        let dims = [length, width, height].sort()

        return 2*length*width + 2*width*height + 2*height*length + (dims[0] * dims[1])
    }

    func ribbonNeeded() -> Int {
        let dims = [length, width, height].sort()

        let wrap = (dims[0] + dims[1]) * 2
        let bow = dims.reduce(1, combine: *)

        return wrap + bow
    }

    init?(packageString: String) {
        let dimensions = packageString.characters
            .split("x")
            .map { String($0) }
            .map { Int($0)! }
        guard dimensions.count == 3 else { return nil }

        length = dimensions[0]
        width = dimensions[1]
        height = dimensions[2]
    }
}

let presentStrings = TextFile.standardInput().readLines()

let presents = presentStrings.map { Present(packageString: $0) }
    .filter { $0 != nil }.map { $0! }

let totalPaper = presents
    .map { $0.paperNeeded() }
    .reduce(0, combine: +)

let totalRibbon = presents
    .map { $0.ribbonNeeded() }
    .reduce(0, combine: +)

print("paper: \(totalPaper) ribbon: \(totalRibbon)")

//: [Next](@next)
