//: [Previous](@previous)

import Foundation

struct Present {
    let l: Int
    let w: Int
    let h: Int

    func paperNeeded() -> Int {
        let dims = [l, w, h].sort()

        return 2*l*w + 2*w*h + 2*h*l + (dims[0] * dims[1])
    }

    func ribbonNeeded() -> Int {
        let dims = [l, w, h].sort()

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

        l = dimensions[0]
        w = dimensions[1]
        h = dimensions[2]
    }
}

let testPresent = Present(packageString: "2x3x4")!
testPresent.paperNeeded()
testPresent.ribbonNeeded()

let input = [#FileReference(fileReferenceLiteral: "presents.txt")#]

let inputData = NSData(contentsOfURL: input)!

let inputString = String(data: inputData, encoding: NSUTF8StringEncoding)!

let presentStrings = inputString.characters.split("\n").map { String($0) }

let presents = presentStrings.map { Present(packageString: $0) }
    .filter { $0 != nil }.map { $0! }

let totalPaper = presents
    .map { $0.paperNeeded() }
    .reduce(0, combine: +)

let totalRibbon = presents
    .map { $0.ribbonNeeded() }
    .reduce(0, combine: +)

print("paper: \(totalPaper) ribbon: \(totalRibbon)")
