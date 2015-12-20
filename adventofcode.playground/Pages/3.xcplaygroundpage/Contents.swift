//: [Previous](@previous)

import Foundation

let input = [#FileReference(fileReferenceLiteral: "directions.txt")#]

let inputData = NSData(contentsOfURL: input)!

let inputString = String(data: inputData, encoding: NSUTF8StringEncoding)!

func visits(directions: String) -> Int {
    var visitedHouses = Set<String>()
    var x = 0
    var y = 0

    visitedHouses.insert("0,0")
    for char in directions.characters {
        switch char {
        case "^":
            y += 1
        case "v":
            y -= 1
        case "<":
            x -= 1
        case ">":
            x += 1

        default:
            break
        }

        let house = "\(x),\(y)"
        visitedHouses.insert(house)
    }
    return visitedHouses.count
}

let visitsResult = visits(inputString)

print(visitsResult)

func roboVisits(directions: String) -> Int {
    var visitedHouses = Set<String>()
    var santaX = 0
    var santaY = 0

    var roboX = 0
    var roboY = 0

    visitedHouses.insert("0,0")
    for (index, char) in directions.characters.enumerate() {
        if index % 2 == 0 {
            switch char {
            case "^":
                santaY += 1
            case "v":
                santaY -= 1
            case "<":
                santaX -= 1
            case ">":
                santaX += 1

            default:
                break
            }

            let house = "\(santaX),\(santaY)"
            visitedHouses.insert(house)
        } else {
            switch char {
            case "^":
                roboY += 1
            case "v":
                roboY -= 1
            case "<":
                roboX -= 1
            case ">":
                roboX += 1

            default:
                break
            }

            let house = "\(roboX),\(roboY)"
            visitedHouses.insert(house)

        }
    }
    return visitedHouses.count
}

roboVisits("^v")
roboVisits("^>v<")
roboVisits("^v^v^v^v^v")
roboVisits(inputString)

//: [Next](@next)
