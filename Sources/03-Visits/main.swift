import AdventLib

let inputString = TextFile.standardInput().readString()

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

let robo = roboVisits(inputString)

print("visits: \(visitsResult) roboVisits: \(robo)")
